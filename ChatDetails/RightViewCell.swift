//
//  RightViewCell.swift
//  ChatSample
//
//  Created by Hafiz on 20/09/2019.
//  Copyright © 2019 Nibs. All rights reserved.
//

import UIKit

class RightViewCell: UITableViewCell {

    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var textMessageLabel: UILabel!
    @IBOutlet weak var messageImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageContainerView.rounded(radius: 12)
        messageContainerView.backgroundColor = UIColor(hexString: "E1F7CB")
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        messageImageView.layer.cornerRadius = 35/2
        messageImageView.layer.borderWidth = 1.0
        messageImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configureCell(message: String) {
        textMessageLabel.text = message
    }
}
