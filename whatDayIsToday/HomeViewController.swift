//
//  HomeViewController.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/09.
//

import FSCalendar
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
        articleTransitionBTN.addTarget(self, action: #selector(transitionArticleVC), for: .touchUpInside)
    }
    @objc private func transitionArticleVC() {
        UserDefaults.standard.set(selectDateString, forKey: "selectDate")
        let articleVC = R.storyboard.article.instantiateInitialViewController()
        self.present(articleVC!, animated: true)
    }
}
extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let tmpDate = Calendar(identifier: .gregorian)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        selectDateString = "\(month)月\(day)日"
        print(selectDateString)
    }
}
