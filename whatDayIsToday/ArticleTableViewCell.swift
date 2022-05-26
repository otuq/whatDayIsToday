//
//  TableViewCell.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/09.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    // MARK: - Properties
    var article: String? {
        didSet {
            articleLabel.text = article
        }
    }
    private let selectView = UIView()

    // MARK: - Outlets

    @IBOutlet var articleLabel: UILabel!
    @IBOutlet var detailedButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectView.backgroundColor = .clear
        selectedBackgroundView = selectView
        articleLabel.isUserInteractionEnabled = false

        detailedButton.layer.borderWidth = 2
        detailedButton.layer.borderColor = UIColor.darkGray.cgColor
        detailedButton.backgroundColor = .clear
        detailedButton.setTitleColor(.darkGray, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
