//
//  ViewController.swift
//  CoffeeTek
//
//  Created by ZED on 19/4/21.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var RegisterBtn: UIButton!
    
    private var realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 30
        loginBtn.layer.borderWidth = 2
        loginBtn.layer.borderColor = UIColor.brown.cgColor

        RegisterBtn.layer.cornerRadius = 30
        RegisterBtn.layer.borderWidth = 2
        RegisterBtn.layer.borderColor = UIColor.brown.cgColor
        
        let login = realm.objects(ProfileUser.self)
        if (login.count > 0){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rs = storyboard.instantiateViewController(withIdentifier: "tabBar")
            self.navigationController?.pushViewController(rs, animated: true)

        }
        

    }

    @IBAction func loginBtn(_ sender: Any) {
      //  style 1
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let goTo = storyboard?.instantiateViewController(withIdentifier: "loginViewController")
//        self.navigationController?.pushViewController(goTo!,animated: true)
       // style 2
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
//        // style 3
//        self.navigationController?.pushViewController(loginViewController(),animated: true)

    }
    
    @IBAction func RegisterBtn(_ sender: Any){
    
        let rs = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController")
        self.navigationController?.pushViewController(rs!, animated: true)
        
    }

}

