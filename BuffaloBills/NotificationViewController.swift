//
//  NotificationViewController.swift
//  BuffaloBills
//
//  Created by venkata baisani on 15/09/23.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var subscribeButtonBactGrdView: UIView!
    @IBOutlet weak var subscribeButton: UIButton!
    
//    let notiStr = "Hey Jeff, \n\n Gate 2 is experiencing heavy queues. Please use Gate 3 for quicker entry. Thank you!"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        textLabel.text = appDelegate?.notiStr
        // Do any additional setup after loading the view.
    
//        subscribeButton.backgroundColor = .clear
//        subscribeButton.layer.cornerRadius = 50/2
//        subscribeButton.layer.borderWidth = 1
//        subscribeButton.layer.borderColor = UIColor.clear.cgColor
        
        
        subscribeButtonBactGrdView.layer.cornerRadius = 55/2
        subscribeButtonBactGrdView.layer.borderWidth = 1.0
        subscribeButtonBactGrdView.layer.borderColor = UIColor.black.cgColor
        
    }
    
    
    @IBAction func backButtonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
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
