//
//  SplashScreen.swift
//  BuffaloBills
//
//  Created by venkata baisani on 14/09/23.
//

import UIKit

class SplashViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var imageViewBuffalo: UIImageView!
    @IBOutlet weak var imageViewBills: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Hiden the images
        imageViewBuffalo.isHidden = true
        imageViewBills.isHidden = true
        imageViewLogo.isHidden = false
        
        
        animateRedLogo()
        
//        navigateNotificationPage()
    }
    
//    func animateFromToptoBottom() {
//
//        UIView.animate(withDuration: 0.6, animations: { [weak self] in
//            let frame = self?.view.frame
//            let yComponent = 0
//            self?.view.frame = CGRect(x: 0, y: yComponent, width: 137, height: 100)
//            UIView.animate(withDuration: 0.6, animations: { [weak self] in
//                let height =  UIScreen.main.bounds.height-yComponent!
//
//                self.bottomValue.constant = height
//                UIView.animate(withDuration: 0.5) {
//                    self.view.layoutIfNeeded()
//                }
//          })
//        })
//
//    }
    
    func animateRedLogo() {
        
        imageViewLogo.isHidden = false
        
        let transition:CATransition = CATransition()
        transition.duration = 2.0
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.default)
        imageViewLogo.layer.add(transition, forKey: kCATransition)
        animationZoomInLogo()
    }
    
    func animationZoomInLogo(){
        
        UIView.transition(with: imageViewLogo, duration:2.0,
          options: [.curveEaseOut, .transitionFlipFromBottom],
          animations: {
            self.imageViewLogo.alpha = 0.5
          },
          completion: { _ in
            self.imageViewLogo.alpha = 1
          }
        )
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            
               // HERE
               self.imageViewLogo.transform = CGAffineTransform.identity.scaledBy(x: 2, y: 2) // Scale your image

         }) { (finished) in
             UIView.animate(withDuration: 1, animations: {
               
                 self.imageViewLogo.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5) // undo in 1 seconds
//                 self.animateBuffaloLogo()
                 self.animateBillsLogo()

           })
        }
    }
    
    func animateBuffaloLogo() {
        
        imageViewBuffalo.isHidden = false
        
        let transition:CATransition = CATransition()
        transition.duration = 2.0
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.default)
        imageViewBuffalo.layer.add(transition, forKey: kCATransition)
//        animateBillsLogo()
    }
    
    func animateBillsLogo() {
        
        imageViewBills.isHidden = false
        
        let transition:CATransition = CATransition()
        transition.duration = 2.0
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.default)
        imageViewBills.layer.add(transition, forKey: kCATransition)
        
        perform(#selector(yourFuncHere2), with: nil, afterDelay: 4.0)
//        navigateNotificationPage()
    }
    
    @objc func yourFuncHere2() {
        print("this is...")
        navigateNotificationPage()
//        navigateToHomepage()
    }
    func navigateToHomepage(){
                
        let navView = TabbarProvider.customTipsStyle(delegate: self)
        navView.modalPresentationStyle = .fullScreen
        self.present(navView, animated: true, completion: nil)
        
    }
    
    func navigateNotificationPage(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let v1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(v1, animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
