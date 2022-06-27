//
//  BirthDayTableViewCell.swift
//  whatDayIsToday
//
//  Created by USER on 2022/06/01.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let selectView = UIView()
    var article: String? {
        didSet {
            articleLabel.text = article
        }
    }

    // MARK: - Outlet,Action
    @IBOutlet var articleLabel: UILabel!

    // MARK: - LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        selectView.backgroundColor = .clear
        selectedBackgroundView = selectView
        articleLabel.isUserInteractionEnabled = false
    }
}
