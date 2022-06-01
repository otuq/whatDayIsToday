//
//  HomeViewController.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/09.
//
import FSCalendar
import PKHUD
import TabPageViewController
import UIKit

class HomeViewController: UIViewController {
    private var selectDateString: String?
    // MARK: Outllets, Actions
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var articleTransitionBTN: UIButton!

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
        let todayDateString = convertDateToString(date: calendar.today!)
        let dateString = selectDateString ?? todayDateString
        UserDefaults.standard.set(dateString, forKey: "selectDate")

        let tabPageVC = TabPageViewController()
        let eventVC = R.storyboard.event.instantiateInitialViewController()
        let birthDayVC = R.storyboard.birthDay.instantiateInitialViewController()
        tabPageVC.tabItems = [(eventVC!, "出来事"), (birthDayVC!, "誕生日")]
        let nav = UINavigationController(rootViewController: tabPageVC)
        tabPageVC.navigationItem.title = "\(dateString)の出来事、誕生日"
        tabPageVC.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButton))
        nav.modalPresentationStyle = .overFullScreen
        HUD.show(.progress)
        self.present(nav, animated: true)
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
        print(selectDateString)
    }
}
