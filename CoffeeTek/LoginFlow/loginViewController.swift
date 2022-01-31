//
//  loginViewController.swift
//  CoffeeTek
//
//  Created by ZED on 19/4/21.
//

import UIKit
import Alamofire
import PhoneNumberKit
import RealmSwift


class loginViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var Spinner: UIActivityIndicatorView!
    @IBOutlet weak var TextPhoneNumber: UITextField!
    @IBOutlet weak var TextPassword: UITextField!
    @IBOutlet weak var invalidPhoneNumber: UILabel!
    @IBOutlet weak var invalidPassword: UILabel!
    
    let phoneNumberKit = PhoneNumberKit()
   
    var  profileData : ProfileModel? = nil
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Spinner.isHidden = true
        isHidden()
//        view.backgroundColor = .brown
      loginBtn.layer.cornerRadius = 25.5
       
    }

    @IBAction func BackBtn(_ sender: Any) {
       // let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        isHidden()
        self.Spinner.isHidden = false
        self.Spinner.startAnimating()
        if validatePhoneNumber(phone: TextPhoneNumber.text!) != true{
            isHidden()
            invalidPhoneNumber.isHidden = false
            return
        }else if TextPassword.text!.count < 6 || TextPassword.text!.count > 20 {
            isHidden()
            invalidPassword.isHidden = false
            return
        }
        print(storeDataToRealm())
        print(DataWithPost())
       
        }
       
    
    
    @IBAction func RegisterBtn(_ sender: Any) {
    
        let push = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController")
        self.navigationController?.pushViewController(push!, animated: true)
        //add target for set func of @objc
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }
//    @objc private func addTapped(){
//        let rootVC = RegisterViewController()
//        let navVC = UINavigationController(rootViewController: rootVC)
//        present(navVC, animated: true)
//    }

    // MARK:-  dataPost
 func DataWithPost (){
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let newController = storyboard.instantiateViewController(withIdentifier: "tabBar")
    let parameter =  ["phone": TextPhoneNumber.text,"password": TextPassword.text]
    AF.request("https://coffeetek.herokuapp.com/login",
               method: .post, parameters: parameter,
               encoder: JSONParameterEncoder.default)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ProfileModel.self){ (respones) in
            
            switch respones.result {
            case .success(let respones):
                print("Success With \(respones)")
                self.profileData = respones
                self.storeDataToRealm()
               
                let alert = UIAlertController(title: "Message", message:"Login success click OK go to Profile", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                    self.navigationController?.pushViewController(newController, animated: false)
                }))
                self.Spinner.stopAnimating()
                self.Spinner.isHidden = true
                self.present(alert, animated: true, completion: nil)
                
            case .failure(let error):
                print("Error With\(error)")
            }
        }
    }
    // MARK:- StoreData Realm
    func storeDataToRealm(){
        
        let uersProfile = ProfileUser()
//        uersProfile._id = ""
//        uersProfile.image = ""
//        uersProfile.name = ""
//        uersProfile.phoneNumber = ""
//        
        realm.beginWrite()
        uersProfile._id = profileData?._id ?? ""
        uersProfile.name = profileData?.name ?? ""
        uersProfile.image = profileData?.image ?? ""
        uersProfile.phoneNumber = profileData?.phoneNumber ?? ""
        realm.add(uersProfile)

        
       try! realm.commitWrite()
    }
    
    
    // MARK:- validate Password & PhoneNumber
    func validatePhoneNumber(phone: String) -> Bool {
        do{
           
            let phoneNumber = try phoneNumberKit.parse(phone, withRegion: "Kh")
            print("success phoneNumber == \(phoneNumber)")
            return true
           
        }catch{
    
//    print("Generic parser error")
            invalidPhoneNumber.isHidden = true
            return false
        }
    }
    
    func isHidden(){
        invalidPhoneNumber.isHidden = true
        invalidPassword.isHidden = true
    }

}
// MARK:- Struct & Class
struct ProfileModel: Decodable {
    let _id : String
    let name: String
    let image: String
    let phoneNumber: String
    let status : Int
}

class ProfileUser: Object {
    @objc dynamic var _id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var phoneNumber: String = ""
    
}
