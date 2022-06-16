//
//  TabPageViewController.swift
//  whatDayIsToday
//
//  Created by USER on 2022/06/02.
//

import UIKit

protocol TabCustomPageViewPresent {
    var viewHeight: CGFloat { get }
}
class TabPageViewController: UIPageViewController {
    // MARK: -Properties
    var currentIndex: ((_ index: Int) -> Void)?
    private var pageViewControllers: [UIViewController] = []
    private var tabPageView: TabPageCustomView!
    private let fetchArticles = ArticlePresentation()
    // MARK: -LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        view.backgroundColor = .white
        settingTabPageView()
        // TabPageCustomViewから選択したtabのindexをクロージャで取得する。
        tabPageView.selectIndex = { [weak self](index: Int) in
            self?.displayControllerWithIndex(index: index)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabPageView.translatesAutoresizingMaskIntoConstraints = false
        [tabPageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         tabPageView.leftAnchor.constraint(equalTo: view.leftAnchor),
         tabPageView.rightAnchor.constraint(equalTo: view.rightAnchor),
         tabPageView.heightAnchor.constraint(equalToConstant: viewHeight)
        ].forEach { $0.isActive = true }
    }
    private func settingTabPageView() {
        let eventVC = R.storyboard.articles.instantiateInitialViewController()
        let birthDayVC = R.storyboard.articles.instantiateInitialViewController()
        guard let eventArticle = fetchArticles.articleExtract(start: 0, end: 1),
              let birthcDayArticle = fetchArticles.articleExtract(start: 1, end: 2) else { return }
        eventVC?.getArticles = { eventArticle }
        birthDayVC?.getArticles = { birthcDayArticle }
        [eventVC!, birthDayVC!].forEach { pageViewControllers.append($0) }
        // 初期画面
        setViewControllers([pageViewControllers[0]], direction: .forward, animated: true)
        tabPageView = TabPageCustomView(size: CGSize(width: view.frame.width, height: viewHeight))
        view.addSubview(tabPageView)
    }
    // tabがタップされたら遷移する
    private func displayControllerWithIndex(index: Int) {
        let direction = index > 0 ? NavigationDirection.forward : NavigationDirection.reverse
        setViewControllers([pageViewControllers[index]], direction: direction, animated: true) { _ in
            // 遷移完了後に選択されたtabのtextColorが変わる
            self.currentIndex?(index)
            self.tabPageView.tabPageCollectionView.reloadData()
        }
    }
}
extension TabPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    private func nextViewController(viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        // controllersの最初のインデックスを取得。それを基準に条件を振り分ける
        guard var index = pageViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        index = isAfter ? index + 1 : index - 1
        if index >= 0 && index < pageViewControllers.count {
            return pageViewControllers[index]
        }
        return nil
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pageViewControllers.count
    }
    // 左スワイプ
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController: viewController, isAfter: false)
    }
    // 右スワイプ
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController: viewController, isAfter: true)
    }
    // 遷移をした後にvcのインデックスを取得
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            return
        }
        // 遷移した先のvcを取得
        let transitionVC = pageViewController.viewControllers?.first
        let transitionIndex = pageViewControllers.firstIndex(of: transitionVC!) ?? 0
        // クロージャに渡す
        currentIndex?(transitionIndex)
        tabPageView.tabPageCollectionView.reloadData()
    }
}
extension TabPageViewController: TabCustomPageViewPresent {
    var viewHeight: CGFloat {
        80
    }
}
