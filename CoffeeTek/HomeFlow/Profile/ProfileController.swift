//
//  ProfileController.swift
//  CoffeeTek
//
//  Created by ZED on 6/5/21.
//

import UIKit
import Alamofire
import RealmSwift
import Kingfisher



class ProfileController: UIViewController {
    
    @IBOutlet weak var ViewColorBrown: UIView!
    @IBOutlet weak var imagePF: UIImageView!
    @IBOutlet weak var ViewColorWhite: UIView!
    @IBOutlet weak var BtnLogout: UIButton!
    
    @IBOutlet weak var lblNamePF: UILabel!
    @IBOutlet weak var PhoneNum: UILabel!

     let realm = try! Realm()
    let userPF = ProfileUser()
    let passDataUpdate = UpdatePFController()
    override func viewDidLoad() {
        super.viewDidLoad()
      
//        let profile = realm.objects(ProfileUser.self)
//
////        profile.last
//        print(profile.count)
//        print(profile.last!)
//        for profileUser in profile{
//            let url = URL(string: profileUser.image)
//            imagePF.kf.setImage(with: url)
//            lblNamePF.text = profileUser.name
//            PhoneNum.text = profileUser.phoneNumber
//
//
//        }
        
        
        imagePF.layer.cornerRadius = 64
        imagePF.layer.borderColor = UIColor.white.cgColor
        imagePF.layer.borderWidth = 1
        BtnLogout.layer.cornerRadius = 5
        
        ViewColorBrown.layer.maskedCorners =  [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        ViewColorBrown.layer.cornerRadius = 20
        ViewColorWhite.layer.cornerRadius = 20
        ViewColorWhite.layer.shadowColor = UIColor.gray.cgColor
        ViewColorWhite.layer.shadowOpacity = 1
        ViewColorWhite.layer.shadowOffset = .zero
        ViewColorWhite.layer.shadowRadius = 10
        
        
//     self.tabBarController?.tabBar.isHidden =
        navigationController?.isNavigationBarHidden = true
        
        let lble1 = UILabel()
        lble1.text = "Profile"
        navigationItem.titleView = lble1
        lble1.textColor = .brown
        
        readDataRealm()
        NotificationCenter.default.addObserver(self, selector: #selector(tapped), name: NSNotification.Name(rawValue: "MessageReceived"), object: nil)
        
//        lblNamePF.text! = passDataUpdate.upDataName
//        PhoneNum.text! = passDataUpdate.upDatePhone
//        let imgURL = URL(string: passDataUpdate.image)
//        self.imagePF.kf.setImage(with: imgURL)

    }
    @objc func tapped(){
        readDataRealm()
//        print("listener logOut ===")
    }
    func readDataRealm(){
        guard let login = realm.objects(ProfileUser.self).last else { return  }
        self.lblNamePF.text = login.name
        self.PhoneNum.text = login.phoneNumber
        let imgURL = URL(string: login.image)
        self.imagePF.kf.setImage(with: imgURL)
//        print(" realm ==\(login)")
    }

    @IBAction func btnAcc(_ sender: Any) {
        let update = storyboard?.instantiateViewController(withIdentifier: "update") as! UpdatePFController
        self.navigationController?.pushViewController(update, animated: true)
    }
    
    @IBAction func btnChangePw(_ sender: Any) {
        let updatePw = storyboard?.instantiateViewController(withIdentifier: "ChangePassword") as! ChangePasswordController
        self.navigationController?.pushViewController(updatePw, animated: true)
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
   
        let alertController = UIAlertController(title: "Log out of CoffeeTek?", message: "Are you sure you want to logout?  Noted that you can seamlessly use CoffeeTek on all your device at once.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "LOG OUT", style: UIAlertAction.Style.destructive) {_ in
            guard let clearData = self.realm.objects(ProfileUser.self).last else { return  }
            try! self.realm.write {
                self.realm.delete(clearData)
                print("delete when logOut== ")
            }
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeView") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: false)
            self.tabBarController?.tabBar.isHidden = true
//            let nav1 = UINavigationController()
//            nav1.viewControllers = [vc]
//            UIApplication.shared.windows.first?.rootViewController = nav1
//            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
        
    
    
}
