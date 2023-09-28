//
//  ChatbotViewController.swift
//  BuffaloBills
//
//  Created by venkata baisani on 15/09/23.
//

import UIKit
import WebKit


class ChatbotViewController: UIViewController {
    
    let chatGPTClient = ChatGPTClient()
    
    @IBOutlet private weak var navView: UIView!
    @IBOutlet private weak var bottomView: UIView!
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var sendTF: UITextField!
    @IBOutlet private weak var sendBtn: UIButton!
    
    @IBOutlet weak var botContraint: NSLayoutConstraint!
    
    var senddata:String = ""
    
    var arrayChatbot:[MessageModel] = []
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isScrollEnabled = false

        // Do any additional setup after loading the view.
//        let request = URLRequest(url: URL(string: "https://wand.ai/c/nrvqgy9se6")!)
//        let request = URLRequest(url: URL(string: "https://app.chatgptbuilder.io/webchat/?p=1889637&ref=1684698787972")!)
//        wkwebview?.load(request)
//        DispatchQueue.main.async {
//            let transition:CATransition = CATransition()
//            transition.duration = 2.0
//            transition.type = CATransitionType.push
//            transition.subtype = CATransitionSubtype.fromTop
//            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.default)
//            self.bottomView.layer.add(transition, forKey: kCATransition)
//            
//        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        //Set up tableview
        setupTable()
    }
    override
    func viewWillAppear(_ animated: Bool) {
        // MARK: Keyboard add Observer by Hide/Show
        
        let input = MessageModel(text: "Welcome to Buffalo Bills Live Chat ! How can we help you today ?" ,side: .left)
        arrayChatbot.append(input)
        tableView.reloadData()

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        scrollView.contentInset.bottom = 0
    }
    
    func setupTable() {
        // config tableView
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
//        tableView.backgroundColor = UIColor(hexString: "E4DDD6")
        tableView.tableFooterView = UIView()
        // cell setup
        tableView.register(UINib(nibName: "RightViewCell", bundle: nil), forCellReuseIdentifier: "RightViewCell")
        tableView.register(UINib(nibName: "LeftViewCell", bundle: nil), forCellReuseIdentifier: "LeftViewCell")
        
    }

    
    @IBAction func backButtonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendButtonAction(sender: UIButton!) {
        
        let input = MessageModel(text: sendTF.text ?? "" ,side: .right)
        arrayChatbot.append(input)
        
        let output = MessageModel(text: "gif@#$!" ,side: .left)
        arrayChatbot.append(output)
        
        tableView.reloadData()
        senddata = sendTF.text ?? ""
        sendTF.text = ""
        self.view.endEditing(true)
        
//        Toast.shared().showToast(withDuration: 100, afterDelay: 0, withMessage: "", toastType: .error, hideToastAfterCompletion: true)
       
        perform(#selector(yourFuncHere2), with: nil, afterDelay: 0.2)
    }
    
    @objc func yourFuncHere2() {
      
        print("this is...")
        chatGPTClient.getChatResponse(prompt: senddata) { result in
            switch result {
            case .success(let text):
                print(text)
                DispatchQueue.main.async {
                    
                    self.arrayChatbot.removeLast()
                    let output = MessageModel(text: text ,side: .left)
                    self.arrayChatbot.append(output)
                    self.tableView.reloadData()
                    self.scrollToLastRow()
//                    Toast.shared().removeExistedToast()
                }
               
            case .failure(let error):
                print(error.localizedDescription)
                self.arrayChatbot.removeLast()
//                Toast.shared().removeExistedToast()
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
           scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height - 20
          scrollView.isScrollEnabled = true
          scrollToLastRow()
       }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        
        scrollView.isScrollEnabled = false
        
        scrollToLastRow()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     */
 
    func scrollToLastRow() {
        let indexPath = NSIndexPath(row: arrayChatbot.count - 1, section: 0)
        self.tableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
    }

}

extension ChatbotViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayChatbot.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = arrayChatbot[indexPath.row]
        if message.side == .left {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftViewCell") as! LeftViewCell
            cell.configureCell(message: message.text)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightViewCell") as! RightViewCell
            cell.configureCell(message: message.text)
            return cell
        }
    }
  
    
}

extension ChatbotViewController: UITextFieldDelegate {
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        scrollView.contentInset.bottom = 0
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        
        textField.resignFirstResponder()
        self.sendButtonAction(sender: sendBtn)
        
        return true
    }
}
