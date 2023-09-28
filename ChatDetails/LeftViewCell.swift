//
//  LeftViewCell.swift
//  ChatSample
//
//  Created by Hafiz on 20/09/2019.
//  Copyright © 2019 Nibs. All rights reserved.
//

import UIKit

class LeftViewCell: UITableViewCell {

    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var textMessageLabel: UILabel!
    @IBOutlet weak var messageImageView: UIImageView!
    
    @IBOutlet weak var bottomImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageContainerView.rounded(radius: 12)
        messageContainerView.backgroundColor = .white
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        messageImageView.layer.cornerRadius = 35/2
        messageImageView.layer.borderWidth = 1.0
        messageImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configureCell(message: String) {
        textMessageLabel.text = message
        
        if message == "gif@#$!"{
            gifFile(boolVal: true)
        } else {
            gifFile(boolVal: false)
        }
    }
    
    func gifFile(boolVal: Bool){
        
        if boolVal {
            messageContainerView.isHidden = true
            textMessageLabel.isHidden = true
            messageImageView.isHidden = true
            bottomImageView.isHidden = false
            
            do {
                let imageData = try Data(contentsOf: Bundle.main.url(forResource: "typing", withExtension: "gif")!)
                self.bottomImageView.image = UIImage.gif(data: imageData)
            } catch {
                print(error)
            }
        
        } else {
            messageContainerView.isHidden = false
            textMessageLabel.isHidden = false
            messageImageView.isHidden = false
            bottomImageView.isHidden = true
            
            self.bottomImageView.image = UIImage.init()
        }
    }
    
}

extension UIView {
    func rounded(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
