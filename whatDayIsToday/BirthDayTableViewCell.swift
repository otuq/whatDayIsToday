//
//  BirthDayTableViewCell.swift
//  whatDayIsToday
//
//  Created by USER on 2022/06/01.
//

import UIKit

class BirthDayTableViewCell: UITableViewCell {
    // MARK: - Properties
    var article: String? {
        didSet {
            birthDayLabel.text = article
        }
    }
    private let selectView = UIView()

    // MARK: - Outlets

    @IBOutlet var birthDayLabel: UILabel!
    @IBOutlet var birthDayButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectView.backgroundColor = .clear
        selectedBackgroundView = selectView
        birthDayLabel.isUserInteractionEnabled = false

        birthDayButton.layer.borderWidth = 2
        birthDayButton.layer.borderColor = UIColor.darkGray.cgColor
        birthDayButton.backgroundColor = .clear
        birthDayButton.setTitleColor(.darkGray, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
