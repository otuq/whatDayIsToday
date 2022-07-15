//
//  Form.swift
//  whatDayIsToday
//
//  Created by USER on 2022/07/13.
//

import Eureka
import SafariServices
import UIKit

class FormRows {
    // MARK: Properties
    // MARK: Methods
    func privacyPolicyRow() -> ButtonRow {
        // プライバシー情報のwebページに遷移
        ButtonRow {
            $0.title = "privacy"
            $0.presentationMode = .presentModally(controllerProvider: ControllerProvider.callback(builder: {
                if let url = URL(string: "https://otuq.github.io/") {
                    let safariVC = SFSafariViewController(url: url)
                    return safariVC
                }
                return UIViewController()
            }), onDismiss: nil)
        }
    }
    func twitterRow() -> ButtonRow {
        // Twitter
        ButtonRow {
            $0.title = "twitter"
            $0.cellStyle = .value1 // 初期ではセルが中央揃えのtintColorがblueに設定してあるので左揃えになるスタイルに変更
        }.cellUpdate { cell, _ in
            // このコールバック関数内でアクセサリーの設定を他のセルのスタイルに合わせる。
            cell.tintColor = UIColor.dynamicColor(light: .black, dark: .white)
            cell.accessoryType = .disclosureIndicator
        }.onCellSelection { _, _ in
            if let url = URL(string: "https://twitter.com/OPQR64013140") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    func versionRow() -> TextRow {
        // version情報
        TextRow("version") {
            $0.title = "version"
            $0.value = "1.0"
            $0.cell.isUserInteractionEnabled = false
        }
    }
}
