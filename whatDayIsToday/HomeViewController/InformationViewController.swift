//
//  InformationViewController.swift
//  whatDayIsToday
//
//  Created by USER on 2022/07/13.
//

import Eureka
import UIKit

class InformationViewController: FormViewController {
    // MARK: - Properties
    private let formRows = FormRows()

    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        settingForm()
    }
    private func settingView() {
        self.statusBarStyleChange(style: .lightContent)
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "アプリの情報"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBarButton))
    }
    @objc private func doneBarButton() {
        statusBarStyleChange(style: .darkContent)
        dismiss(animated: true, completion: nil)
    }
    private func settingForm() {
        form +++ Section("information")
            <<< formRows.privacyPolicyRow()
            <<< formRows.twitterRow()
            <<< formRows.versionRow()
    }
}
