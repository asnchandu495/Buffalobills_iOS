//
//  HomeViewController.swift
//  BuffaloBills
//
//  Created by venkata baisani on 14/09/23.
//

import UIKit


class NewsViewController: UIViewController,ProtocolDelegate {
    
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
  
    @IBOutlet weak var itemBarView: UIView!
    @IBOutlet weak var itemButton: UIButton!
    
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var itemView1: UIView!
    @IBOutlet weak var itemView2: UIView!
    @IBOutlet weak var itemView3: UIView!
    @IBOutlet weak var itemView4: UIView!
    @IBOutlet weak var itemView5: UIView!
    
    @IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var downLabel: UILabel!
    @IBOutlet weak var downarrowButton: UIButton!
    
    @IBOutlet weak var chatbotView: UIView!
    
    @IBOutlet weak var widthChatBot: NSLayoutConstraint!
    
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var playImage: UIImageView!
    

    var titleArray:[String] = ["Climbing the AFC East: Bills' Quest for Dominance","Highlight Reel:\nDon't Miss the Best of the Season","Week 3 - Sept 14\nBills vs. Commanders","Your Highmark Stadium Experience","Buffalo Bills \nOfficial Online \nStore","Bills Mafia \nFan Room"]
    
    
    let selColor = UIColor(hexString: "#5170B7")
    
    let deSelColor = UIColor(hexString: "#264CA5")
    
    let initialVal: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = deSelColor
        selView(tagVal: initialVal)
        // Do any additional setup after loading the view.
        
        chatbotView.layer.cornerRadius = 55/2
        chatbotView.layer.borderWidth = 1.0
        chatbotView.layer.borderColor = UIColor.black.cgColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(filterDoneAction(_:)), name: NSNotification.Name(rawValue: "filter"), object: nil)
    }
    
    @objc func filterDoneAction (_ notification:Notification) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let v1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController

            self.navigationController?.pushViewController(v1, animated: false)
        }
    }
    
    @IBAction func chatAction(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let v1 = storyboard.instantiateViewController(withIdentifier: "ChatbotViewController") as! ChatbotViewController
        self.navigationController?.pushViewController(v1, animated: true)
    }
    
    @IBAction func notificationAction(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let v1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController

        self.navigationController?.pushViewController(v1, animated: true)
    }
    
    @IBAction func moreAction(sender: UIButton!) {
       
        ToastCoordinator.displayOverStatusBar = true
        self.navigationController?.view.showToast(embedding: ToastContentView.create(), duration: 0.4)
        
        perform(#selector(yourFuncHere2), with: nil, afterDelay: 2.0)
        
    }
    
    @objc func yourFuncHere2() {
        print("this is...")
        self.navigationController?.view.hideToast(duration: 0.4)
//        navigateToHomepage()
    }
    
    @IBAction func viewSel(sender: UIButton!) {
        let tagVal = sender.tag
        
        selView(tagVal: tagVal)
//        print(tagVal)
    }
    
    @IBAction func menuButtonAction(sender: UIButton!) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        
        menuViewController.view.backgroundColor = UIColor.clear
        menuViewController.modalPresentationStyle = .overFullScreen
        menuViewController.modalTransitionStyle = .crossDissolve
        menuViewController.isModalInPresentation = true
        menuViewController.delegate = self

//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        transition.type = CATransitionType.moveIn
//        transition.subtype = CATransitionSubtype.fromLeft
//        navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.present(menuViewController, animated: true)
//        self.navigationController?.pushViewController(menuViewController, animated: true)
        
    }
    func didSelectRow(tagVal: Int) {
        
        DispatchQueue.main.async {
            self.selView(tagVal: tagVal)
        }
        
    }
    func didNavigationView(tagVal:Int){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let v1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            
            self.navigationController?.pushViewController(v1, animated: true)
        }
    }

    func selView(tagVal: Int) {
        
       
        playImage.isHidden = true
      
        switch tagVal {
        case 0:
            itemView.backgroundColor = selColor
            itemView1.backgroundColor = deSelColor
            itemView2.backgroundColor = deSelColor
            itemView3.backgroundColor = deSelColor
            itemView4.backgroundColor = deSelColor
            itemView5.backgroundColor = deSelColor
            
            downLabel.text = "ALL NEWS"
            imageBack.image = UIImage(named: "Frame 0")
            
            chatbotView.isHidden = true
            
            mainLabel.text = titleArray[0]
            
            break
            // executable code
        case 1:
            
            itemView.backgroundColor = deSelColor
            itemView1.backgroundColor = selColor
            itemView2.backgroundColor = deSelColor
            itemView3.backgroundColor = deSelColor
            itemView4.backgroundColor = deSelColor
            itemView5.backgroundColor = deSelColor
            
            downLabel.text = "ALL VIDEOS"
            imageBack.image = UIImage(named: "Frame 1")
            
            mainLabel.text = titleArray[1]
            
            chatbotView.isHidden = true
            
            playImage.isHidden = false
            
            break
            // executable code
        case 2:
            itemView.backgroundColor = deSelColor
            itemView1.backgroundColor = deSelColor
            itemView2.backgroundColor = selColor
            itemView3.backgroundColor = deSelColor
            itemView4.backgroundColor = deSelColor
            itemView5.backgroundColor = deSelColor
            
            downLabel.text = "ALL GAMES"
            imageBack.image = UIImage(named: "Frame 2")
            
            chatbotView.isHidden = true
            
//            mainLabel.text = titleArray[tagVal]
            
            let attrStri = NSMutableAttributedString.init(string:titleArray[tagVal])
            let nsRange = NSString(string: titleArray[tagVal])
                    .range(of: "Week 3 - Sept 14", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.font: UIFont.init(name: "Helvetica", size: 18.0) as Any
            ], range: nsRange)
            self.mainLabel.attributedText = attrStri
            
            break
            // executable code
        case 3:
            itemView.backgroundColor = deSelColor
            itemView1.backgroundColor = deSelColor
            itemView2.backgroundColor = deSelColor
            itemView3.backgroundColor = selColor
            itemView4.backgroundColor = deSelColor
            itemView5.backgroundColor = deSelColor
            
            downLabel.text = "DISCOVER MORE"
            imageBack.image = UIImage(named: "Frame 3")
            
            chatbotView.isHidden = true
            
            mainLabel.text = titleArray[3]
            
            break
            // executable code
        case 4:
            itemView.backgroundColor = deSelColor
            itemView1.backgroundColor = deSelColor
            itemView2.backgroundColor = deSelColor
            itemView3.backgroundColor = deSelColor
            itemView4.backgroundColor = selColor
            itemView5.backgroundColor = deSelColor
            
            downLabel.text = "SHOP NOW"
            imageBack.image = UIImage(named: "Frame 4")
            
            chatbotView.isHidden = true
            
            mainLabel.text = titleArray[4]
            
            break
            // executable code
        case 5:
            itemView.backgroundColor = deSelColor
            itemView1.backgroundColor = deSelColor
            itemView2.backgroundColor = deSelColor
            itemView3.backgroundColor = deSelColor
            itemView4.backgroundColor = deSelColor
            itemView5.backgroundColor = selColor
            
            downLabel.text = "BILLS MAFIA FAN ROOM"
            imageBack.image = UIImage(named: "Frame 5")
            
            self.widthChatBot.constant = 56
            self.chatbotView.layoutIfNeeded()
            
            mainLabel.text = titleArray[5]
            
            //176
            perform(#selector(chatFloatAction), with: nil, afterDelay: 0.5)
           
            break
            // executable code
        default:
            itemView.backgroundColor = selColor
            itemView1.backgroundColor = deSelColor
            itemView2.backgroundColor = deSelColor
            itemView3.backgroundColor = deSelColor
            itemView4.backgroundColor = deSelColor
            itemView5.backgroundColor = deSelColor
            
            downLabel.text = "ALL NEWS"
            imageBack.image = UIImage(named: "Frame 0")
            
            mainLabel.text = titleArray[0]
            
            chatbotView.isHidden = true
            
            break
            // executable code
        }
    }
    
    @objc func chatFloatAction() {
        print("this is...")
        UIView.animate(withDuration: 0.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            
               // HERE
            self.chatbotView.isHidden = false

         }) { (finished) in
             UIView.animate(withDuration: 0.2, animations: {
               
                 self.widthChatBot.constant = 176
                 self.chatbotView.layoutIfNeeded()

           })
        }
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


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIView {

    /** This is the function to get subViews of a view of a particular type
*/
    func subViews<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T{
                all.append(aView)
            }
        }
        return all
    }


/** This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T */
        func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
            var all = [T]()
            func getSubview(view: UIView) {
                if let aView = view as? T{
                all.append(aView)
                }
                guard view.subviews.count>0 else { return }
                view.subviews.forEach{ getSubview(view: $0) }
            }
            getSubview(view: self)
            return all
        }
    }
