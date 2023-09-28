//
//  ExampleHighlightableContentView.swift
//  ESTabBarControllerExample
//
//  Created by lihao on 2017/2/9.
//  Copyright © 2018年 Egg Swift. All rights reserved.
//

import UIKit

class ExampleHighlightableContentView: ExampleBackgroundContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let transform = CGAffineTransform.identity
        imageView.transform = transform.scaledBy(x: 1.15, y: 1.15)
        
    

    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
//        UIView.beginAnimations("small", context: nil)
//        UIView.setAnimationDuration(0.2)
//        let transform = imageView.transform.scaledBy(x: 0.8, y: 0.8)
//        imageView.transform = transform
//        UIView.commitAnimations()
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            
               // HERE
            self.imageView.transform = CGAffineTransform.identity.scaledBy(x: 4, y: 4) // Scale your image

         }) { (finished) in
             UIView.animate(withDuration: 1, animations: {
                 self.imageView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9) // undo in 1 seconds
           })
        }
        
        
        completion?()
    }
    
    override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
//        UIView.beginAnimations("big", context: nil)
//        UIView.setAnimationDuration(0.2)
//        let transform = CGAffineTransform.identity
//        imageView.transform = transform.scaledBy(x: 1.15, y: 1.15)
//        UIView.commitAnimations()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
               // HERE
            self.imageView.transform = CGAffineTransform.identity.scaledBy(x: 1.15, y: 1.15) // Scale your image

         }) { (finished) in
             UIView.animate(withDuration: 1, animations: {
                 self.imageView.transform = CGAffineTransform.identity.scaledBy(x: 1.20, y: 1.20) // undo in 1 seconds
           })
        }
        
        completion?()
    }
    
}
