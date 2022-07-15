//
//  Extensions.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/09.
//

import UIKit

extension UIButton {
    func properties() {
        layer.cornerRadius = 10
        layer.borderWidth = 1.0
        layer.masksToBounds = true
        layer.borderColor = UIColor.darkGray.cgColor
        layer.shadowOffset = .init(width: 1, height: 1.5)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 1

        contentMode = .scaleAspectFit
        isUserInteractionEnabled = true
    }
}
extension String {
    func textSizeCalc(width: CGFloat, attribute: [NSAttributedString.Key: Any]) -> CGSize {
        let bounds = CGSize(width: width, height: .greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let rect = (self as NSString).boundingRect(with: bounds, options: options, attributes: attribute, context: nil)
        return CGSize(width: rect.size.width, height: rect.size.height)
    }
}
extension Notification.Name {
    static let currentDate = Notification.Name("currentDate")
}
extension CALayer {
    func dropShadow() {
        shadowOffset = .init(width: 1.5, height: 1.5)
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.3
        shadowRadius = 1
    }
}
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while true {
            guard let nextResponder = parentResponder?.next else { return nil }
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            parentResponder = nextResponder
        }
    }
}
extension UINavigationController {
    func presentationSetting(parentVC: UIViewController, presentingVC: UIViewController, title: String) {
        presentingVC.navigationItem.title = title
        presentingVC.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: parentVC, action: #selector(closeButton))
        modalPresentationStyle = .overFullScreen
        parentVC.present(self, animated: true)
    }
    @objc private func closeButton() {
    }
}
extension UIColor {
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        UIColor { (traitCollection: UITraitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return dark
            } else {
                return light
            }
        }
    }
}
extension UIViewController {
    // ステータスバーの色スタイルを動的に変更する
    func statusBarStyleChange(style: UIStatusBarStyle) {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            // 最前面VCの取得
            guard let rootVC = UIApplication.shared.keyWindow?.rootViewController as? HomeViewController else { return }
            rootVC.statusBarStyle = style
            UIView.animate(withDuration: 1) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }}
