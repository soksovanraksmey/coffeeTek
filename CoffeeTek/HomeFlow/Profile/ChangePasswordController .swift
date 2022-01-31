//
//  ChangePwController .swift
//  CoffeeTek
//
//  Created by ZED on 1/6/21.
//

import UIKit
import RealmSwift

class ChangePasswordController: UIViewController {
    
    @IBOutlet weak var viewBrown: UIView!
    @IBOutlet weak var viewWrite: UIView!
    @IBOutlet weak var PhoneNumber: UITextField!
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var btnChange: UIButton!
    
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        btnChange.layer.cornerRadius = 10
        viewBrown.layer.cornerRadius = 20
        viewBrown.layer.maskedCorners =  [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        viewWrite.layer.cornerRadius = 20
        
        viewWrite.layer.shadowOpacity = 0.5
        viewWrite.layer.shadowOffset = .zero
        viewWrite.layer.shadowRadius = 10
        passingData()
        NotificationCenter.default.addObserver(self, selector: #selector(tapped), name: NSNotification.Name(rawValue: "MessageReceived"), object: nil)
    
    }// viewDidload
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnChange(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Changing your password", message: "Make sure do you want to change  your password!", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
            
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        

    }// btnChange
    @objc func tapped(){
        passingData()
    }
    
    func passingData() {
        guard  let login = realm.objects(ProfileUser.self).last else { return }
        self.PhoneNumber.text = login.phoneNumber
        
    }

    
    
}// viewController
