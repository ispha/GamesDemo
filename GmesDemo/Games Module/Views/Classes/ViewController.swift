//
//  ViewController.swift
//  CodeLine
//
//  Created by ispha on 5/24/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK- outlets
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var tabBarInnerView: DesignableUIView!
    @IBOutlet weak var tabBarConstraintBtom: NSLayoutConstraint!
    
    @IBOutlet weak var btn3ConstraintTop: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       doAnyAdditionalSetup()
    }
    func doAnyAdditionalSetup()
    {
		self.navigationController?.navigationBar.isHidden = true
		HelpingMethods().dropShadow(view: tabBarInnerView)
		NotificationCenter.default.addObserver(self,
												 selector: #selector(self.refreshNow),
												 name: NSNotification.Name(rawValue: "refreshNow"),
												 object: nil)
        SingletoneClass.sharedInstance.tabbarView = tabBarView
        SingletoneClass.sharedInstance.tabBarInnerView = tabBarInnerView
        SingletoneClass.sharedInstance.tabbarConstraintBotm = tabBarConstraintBtom
    }
	@objc func refreshNow(_ notif: NSNotification){
		let newIndex =  notif.userInfo?["new_index"] as? Int
		showHideBasedOnIndex(index: newIndex! + 1)


	}
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //btn3ConstraintTop.constant = -btn3.frame.size.height / 2
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func showHideBasedOnIndex(index:Int)
    {
        switch index {
        case 1:
			btn1.setTitleColor(HelpingMethods.colorWithHexString(Constants.Colors.blueColor), for: .normal)
			btn1.tintColor = HelpingMethods.colorWithHexString(Constants.Colors.blueColor)
			btn2.setTitleColor(.lightGray, for: .normal)
			btn2.tintColor = .lightGray
            break
        case 2:
			btn2.setTitleColor(HelpingMethods.colorWithHexString(Constants.Colors.blueColor), for: .normal)
			btn2.tintColor = HelpingMethods.colorWithHexString(Constants.Colors.blueColor)
			btn1.setTitleColor(.lightGray, for: .normal) 
			btn1.tintColor = .lightGray
            break
        default:
            break
        }
    }
    // MARK- Actions
    @IBAction func actionofbtn1(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshNow"), object: self, userInfo: ["new_index":0])
    }
    @IBAction func actionofbtn2(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshNow"), object: self, userInfo: ["new_index":1])
    }
    
}

