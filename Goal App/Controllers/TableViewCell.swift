//
//  TableViewCell.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 16/07/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"

    @IBOutlet var taskLabel: UILabel!
    @IBOutlet var checkBox: UIImageView!

    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 25
        contentView.layer.masksToBounds = true
    }

    func configureCell(selected: Bool) {
        if selected {
            checkBox?.image = UIImage(systemName: "checkmark.square.fill")
            checkBox?.tintColor = UIColor(rgb: 0x49A4B5)
            taskLabel?.textColor = UIColor.systemGray
        } else {
            checkBox?.image = UIImage(systemName: "square")
            taskLabel?.textColor = UIColor.black
            checkBox.tintColor = UIColor.systemGray3
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
