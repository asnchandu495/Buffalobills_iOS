//
//  MenuViewController.swift
//  BuffaloBills
//
//  Created by venkata baisani on 17/09/23.
//

import UIKit

protocol ProtocolDelegate {
    func didSelectRow(tagVal:Int)
    func didNavigationView(tagVal:Int)
}


class MenuViewController: UIViewController, UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var userProfilePicImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userMobileNumLabel: UILabel!
    
    @IBOutlet weak var menuTableView: UITableView!

    @IBOutlet weak var logoutIconImageView: UIImageView!
    @IBOutlet weak var logoutLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var backgroundImage: UIView!
    
     var delegate: ProtocolDelegate?
    
    var dataArray:[String] = ["News","Videos","Schedule","Stadium","Store","MafiaGPT","Fan Room","Best Entry Route","Settings", "Sign Out"]
    
    let nameString = "Bryan Stehler"
    let emailString = "bryan.bills86@gmail.com"
    let phoneString = "+1 999 345 5533"

    override func viewDidLoad() {
        super.viewDidLoad()
        //  self.addTapGestures()
        self.tableViewSetup()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        backgroundImage.addGestureRecognizer(tap)
                
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // DispatchQueue.main.async {
           
     
            self.menuTableView.reloadData()
            self.animateTableview()
            self.assignProfileDetails()
           
       // }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        if let draw = self.drawer() {
//            draw.showRightSlider(isShow: false)
//        }
    }
    
    
    // MARK : - Common delegates
    
    // MARK: - Custom Methods for Default setups
    private func setUpAll() {
        self.tableViewSetup()
    }
    
  
   
    
    internal func tableViewSetup(){
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.menuTableView.tableFooterView = UIView()
        self.menuTableView.estimatedRowHeight = 60.0
        self.menuTableView.rowHeight = UITableView.automaticDimension
        self.menuTableView.isHidden = false
        self.menuTableView.tableFooterView = UIView()
        self.menuTableView.tableFooterView?.backgroundColor = UIColor.white
    }
    
   
    
    internal func setupView() {
        
        self.menuTableView.tableFooterView = UIView()
        self.userProfilePicImageView.layer.borderWidth = 2.0
        self.userProfilePicImageView.layer.borderColor = UIColor.clear.cgColor
        
    
        setUpAll()
    
    }
    
    //MARK: - Animation Methods
    
    ///Method which animates menu table view cells
    func animateTableview() {
        var index:Double = 0
        self.menuTableView.reloadData()
        let tableWidth:CGFloat = self.menuTableView.bounds.size.width
        for cell in self.menuTableView.visibleCells {
            cell.transform = CGAffineTransform(translationX: -tableWidth, y: 0)
        }
        for cell in self.menuTableView.visibleCells {
            UIView.animate(withDuration: 0.7, delay: 0.07*index , usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options:UIView.AnimationOptions(rawValue: 0) , animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
    }
    //MARK: - Custom Methods
    
    /// Method which assign profile details to properties
    private func assignProfileDetails() {
       
        self.userNameLabel.text = nameString
        self.userMobileNumLabel.text = phoneString
        self.userEmailLabel.text = emailString
        
        self.userProfilePicImageView.image = UIImage(named: "profile")
        
        
        self.logoutLabel.text = dataArray[dataArray.count-1]
        self.logoutIconImageView.image = UIImage(named: dataArray[dataArray.count-1])
       
    }
    /// Method which deallocates delegate and data source of table view
    private func resetTableView(){
        self.menuTableView.delegate = nil
        self.menuTableView.dataSource = nil
    }
    
  
    @IBAction func closeButton(_ sender :UIButton) {

//        self.navigationController?.popViewController(animated: true)
//        self.navigationController?.dismiss(animated: true)
        self.dismiss(animated: true)
    }
    // MARK:- Logout delegates
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.dismiss(animated: true)
    }
   
    
    // MARK: TableViewSetup
    
 
    // MARK: - UITableView Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }

            cell.selectionStyle = .none
            cell.menuHeaderLabel?.text = dataArray[indexPath.row]
            cell.imageView?.image = UIImage(named: dataArray[indexPath.row])
        
      
            return cell
      
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return (section == self.viewModel.menuTitles.count - 1) ? 0 : 1
//    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = UIView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 1))
//        let footerLabel = UILabel.init(frame: CGRect(x: 16, y: 0, width: screenWidth, height: 1))
//        footerLabel.backgroundColor = UIColor.R213_G213_B213
//        footerView.addSubview(footerLabel)
//        return footerView
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            
            if indexPath.row == 7 || indexPath.row == 8 {
                self.dismiss(animated: false)
                self.delegate?.didNavigationView(tagVal: indexPath.row)
            } else{
                self.dismiss(animated: true)
                self.delegate?.didSelectRow(tagVal: indexPath.row)
            }
        }

    }
    
   
    /// Method which gets an insatnce of a view controller
    ///
    /// - Parameters:
    ///   - bundle: Story board name
    ///   - id: View Controller identifier
    /// - Returns: View Controller
    private func createViewControllerFrom<T: UIViewController>(bundle: String, hasIdentifier id: String) -> T? {
        let storyBoard = UIStoryboard(name: bundle, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: id) as? T
    }
    
    /// Method which navigates to next screen
    ///
    /// - Parameter viewController: View controller i.e., next screen
    private func pushTo(_ viewController: UIViewController) {
       // self.drawer()?.navigationController?.pushViewController(viewController, animated: true)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
   
    
    
}
