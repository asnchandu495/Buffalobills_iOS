//
//  ProfileTableViewCell.swift
//  AthletafiedCoach
//
//  Created by CompIndia on 25/01/21.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    
    @IBOutlet var menuIconImageView: UIImageView!
    
    @IBOutlet var menuHeaderLabel: UILabel!
    
    @IBOutlet var forwordButton: UIButton!
    
    @IBOutlet var underLine: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
