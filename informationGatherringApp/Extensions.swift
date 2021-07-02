//
//  Extensions.swift
//  informationGatherringApp
//
//  Created by USER on 2021/05/24.
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
