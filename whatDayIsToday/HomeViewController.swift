//
//  HomeViewController.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/09.
//
import FSCalendar
import UIKit
import PKHUD

class HomeViewController: UIViewController {
    // MARK: -Properties
    private var selectDateString: String?
    // MARK: Outllet, Action
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var articleTransitionBTN: UIButton!
    // MARK: -LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        settingDelegate()
        settingUI()
    }
    private func settingDelegate() {
        calendar.delegate = self
        calendar.dataSource = self
    }
    private func settingUI() {
        calendar.layer.borderWidth = 1.5
        calendar.layer.cornerRadius = 10
        calendar.layer.dropShadow()
        articleTransitionBTN.layer.borderWidth = 1.5
        articleTransitionBTN.layer.cornerRadius = 10
        articleTransitionBTN.layer.dropShadow()
        articleTransitionBTN.addTarget(self, action: #selector(transitionArticleVC), for: .touchUpInside)
    }
    @objc private func transitionArticleVC() {
        // インジケータが表示された後に次の処理を実行しないとインジケータの表示に遅れが出てしまうため
        // dispatchGroupを使って順番にキューを追加し並列処理にする。
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "queue")
        // グループにキューを追加しメインスレッドで並列処理を実行する
        queue.async(group: dispatchGroup, execute: {
            DispatchQueue.main.sync {
                HUD.show(.progress)
            }
        })
        // インジケータの並列処理が実行された後にキューを追加しメインスレッドで並列処理を実行する
        queue.async(group: dispatchGroup, execute: {
            DispatchQueue.main.sync {
                self.instantiateTabPageVC()
            }
        })
    }
    private func instantiateTabPageVC() {
        let todayDateString = convertDateToString(date: calendar.today!)
        let dateString = selectDateString ?? todayDateString
        UserDefaults.standard.set(dateString, forKey: "selectDate")
        let tabPageVC = R.storyboard.tabPage.instantiateInitialViewController()
        let nav = UINavigationController(rootViewController: tabPageVC!)
        tabPageVC?.navigationItem.title = "\(dateString)の出来事、誕生日"
        tabPageVC?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButton))
        nav.modalPresentationStyle = .overFullScreen
        present(nav, animated: true)
    }
    @objc private func closeButton() {
        dismiss(animated: true)
    }
    private func convertDateToString(date: Date) -> String {
        let tmpDate = Calendar(identifier: .gregorian)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        return "\(month)月\(day)日"
    }
}
extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectDateString = convertDateToString(date: date)
    }
}
