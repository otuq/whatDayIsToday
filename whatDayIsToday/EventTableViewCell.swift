//
//  TableViewCell.swift
//  whatDayIsToday
//
//  Created by USER on 2022/05/09.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    // MARK: - Properties
    var article: String? {
        didSet {
            eventLabel.text = article
        }
    }
    private let selectView = UIView()

    // MARK: - Outlets

    @IBOutlet var eventLabel: UILabel!
    @IBOutlet var eventButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectView.backgroundColor = .clear
        selectedBackgroundView = selectView
        eventLabel.isUserInteractionEnabled = false

        eventButton.layer.borderWidth = 2
        eventButton.layer.borderColor = UIColor.darkGray.cgColor
        eventButton.backgroundColor = .clear
        eventButton.setTitleColor(.darkGray, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
