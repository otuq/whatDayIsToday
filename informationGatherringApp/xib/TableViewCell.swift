//
//  TableViewCell.swift
//  informationGatherringApp
//
//  Created by USER on 2021/05/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    // MARK: - Properties
    //    var model: Result? {
    //        didSet{
    //
    //        }
    //    }

    // MARK: - Outlets
    @IBOutlet var articleTextView: UITextView!
    @IBOutlet var detailedButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        articleTextView.isUserInteractionEnabled = false

        detailedButton.layer.borderWidth = 10
        detailedButton.layer.borderColor = UIColor.darkGray.cgColor
        detailedButton.backgroundColor = .clear
        detailedButton.setTitleColor(.darkGray, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
