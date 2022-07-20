//
//  TableViewCell.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 16/07/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var checkBox: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        checkBox.image =  UIImage(systemName: "square")
    }
    
    func taskCompleted(){
        checkBox.image = UIImage(systemName: "checkmark.square.fill")
        checkBox.tintColor = UIColor(rgb: 0x49A4B5)
        taskLabel.textColor = UIColor.systemGray
    }
    
}
