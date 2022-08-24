//
//  TableViewCell.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 16/07/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var checkBox: UIImageView!
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 25
        self.contentView.layer.masksToBounds = true
    }
    
    func configureCell(selected: Bool) {
        if selected {
            self.checkBox?.image = UIImage(systemName: "checkmark.square.fill")
            self.checkBox?.tintColor = UIColor(rgb: 0x49A4B5)
            self.taskLabel?.textColor = UIColor.systemGray
        } else {
            checkBox?.image =  UIImage(systemName: "square")
            taskLabel?.textColor = UIColor.black
            checkBox.tintColor = UIColor.systemGray3
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
