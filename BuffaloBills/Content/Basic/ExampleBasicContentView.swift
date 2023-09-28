//
//  ExampleBasicContentView.swift
//  ESTabBarControllerExample
//
//  Created by lihao on 2017/2/9.
//  Copyright © 2018年 Egg Swift. All rights reserved.
//

import UIKit
import ESTabBarController

class ExampleBasicContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        textColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            let frameValue = self.titleLabel.frame
            let yvalue = 50
            self.titleLabel.frame = CGRect(x: frameValue.origin.x, y: CGFloat(yvalue), width: frameValue.size.width, height: frameValue.size.height)
        }
   
    }
    
//    override func updateLayout() {
//        let frameValue = self.titleLabel.frame
//        let yvalue = frameValue.origin.y - 20
//        titleLabel.frame = CGRect(x: frameValue.origin.x, y: yvalue, width: frameValue.size.width, height: frameValue.size.height)
//    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
