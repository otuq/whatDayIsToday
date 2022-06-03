//
//  TabPageViewController.swift
//  whatDayIsToday
//
//  Created by USER on 2022/06/02.
//

import UIKit

class TabPageViewController: UIPageViewController {
    var pageViewControllers: [UIViewController] = []

    private var beforeIndex: Int = 0
    private var currentIndex: Int? {
        guard let viewController = viewControllers?.first else {
            return nil
        }
        return pageViewControllers.firstIndex(of: viewController)
    }
    private let tabPageView = TabPageCustomView()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
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
         tabPageView.heightAnchor.constraint(equalToConstant: 80)
        ].forEach { $0.isActive = true }
    }
    private func settingTabPageView() {
        let eventVC = R.storyboard.event.instantiateInitialViewController()
        let birthDayVC = R.storyboard.birthDay.instantiateInitialViewController()
        [birthDayVC!, eventVC!].forEach { pageViewControllers.append($0) }
        // 初期画面
        setViewControllers([pageViewControllers[0]], direction: .forward, animated: true)
        view.addSubview(tabPageView)
    }
    private func displayControllerWithIndex(index: Int) {
        let direction = index > 0 ? NavigationDirection.forward : NavigationDirection.reverse
        setViewControllers([pageViewControllers[index]], direction: direction, animated: true)
    }
}
extension TabPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    private func nextViewController(viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        // controllersの最初のインデックスを取得。それを基準に条件を振り分ける
        guard var index = pageViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        if isAfter {
            index += 1
        } else {
            index -= 1
        }
        if index < 0 {
            index = pageViewControllers.count - 1
        } else if index == pageViewControllers.count {
            index = 0
        }

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
        nextViewController(viewController: viewController, isAfter: false)
    }
    // 右スワイプ
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        nextViewController(viewController: viewController, isAfter: true)
    }
}
