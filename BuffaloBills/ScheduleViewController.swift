//
//  ScheduleViewController.swift
//  BuffaloBills
//
//  Created by venkata baisani on 14/09/23.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var itemTextView: UITextView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.itemTextView.text = appDelegate.localFCMToken
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
}
