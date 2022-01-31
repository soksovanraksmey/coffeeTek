//
//  UpdatePFController.swift
//  CoffeeTek
//
//  Created by ZED on 20/5/21.
//

import UIKit
import Kingfisher
import RealmSwift
import Alamofire
import PhoneNumberKit

class UpdatePFController: UIViewController {
    @IBOutlet weak var ViewBrown: UIView!
    @IBOutlet weak var whiteView: UIView!

    @IBOutlet weak var phoneNumPF: UITextField!
    @IBOutlet weak var namePF: UITextField!
    @IBOutlet weak var BtnSetectPF: UIButton!
    
    @IBOutlet weak var imagePF: UIImageView!
    @IBOutlet weak var BtnUpdate: UIButton!
    
    var upDataName = String()
    var upDatePhone = String()
    var userID = String()
    var image = String()
    var profileData : ProfileModel? = nil
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BtnSetectPF.layer.cornerRadius = 64
        BtnUpdate.layer.cornerRadius = 10
        
        imagePF.layer.cornerRadius = 64
        ViewBrown.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        imagePF.layer.borderWidth = 1
        imagePF.layer.borderColor = UIColor.white.cgColor
        ViewBrown.layer.cornerRadius = 20
        whiteView.layer.cornerRadius = 20
        
        whiteView.layer.shadowOpacity = 0.5
        whiteView.layer.shadowOffset = .zero
        whiteView.layer.shadowRadius = 10
        self.navigationController?.isNavigationBarHidden = true
        
        if image.isEmpty{
            passingData()
            viewDidDisappear(false)
//            print("view didsappear false===")
        }

    } // viewDidload
    override func viewDidDisappear(_ animated: Bool) {
        guard let login = realm.objects(ProfileUser.self).last else { return  }
        let imgURL = URL(string: login.image)
        self.imagePF.kf.setImage(with: imgURL)
    }

    //MARK:- pass Data func
    func passingData(){
    guard let profile = realm.objects(ProfileUser.self).last else { return }
        
    let imgURL = URL(string: profile.image)
    self.imagePF.kf.setImage(with: imgURL)
    self.userID = profile._id
    self.namePF.text = profile.name
    self.phoneNumPF.text = profile.phoneNumber
//        print("load data again realm ==\(login)")
       
//    let updatePf = UpdatePFController()
    
        
}

    @IBAction func btnSetectPF(_ sender: Any) {
        let PF = storyboard?.instantiateViewController(withIdentifier: "changePF") as! ChangeAvatarController
        PF.callback = {value in
            self.image = value ?? ""
            self.viewDidDisappear(true)
            print(" view didsappear true ")
        }
        self.navigationController?.pushViewController(PF, animated: true)
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
 
    @IBAction func BtnUpdate(_ sender: Any) {
        
        let login = realm.objects(ProfileUser.self).last
//        self.userID = login?._id ?? ""
//        let phone = isValidName(name: phoneNumPF.text!)
//        if phone != true{
//            let alert = UIAlertController(title: "Message", message: "PhoneNumber is not symbol", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler:nil))
//            self.present(alert, animated: true, completion: nil)
//            return
//        }
        
        //MARK:- nameValid
        let nameValid = isValidName(name: namePF.text!)
        if nameValid != true{
            let alert = UIAlertController(title: "Message", message: "Your name make sure capital, lowercase, uppercase, space and undersocr.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler:nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        //
        if namePF.text!.isEmpty {
            let alert = UIAlertController(title: "Message", message: " Make sure UserName must not be blank!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler:nil))
            self.present(alert, animated: true, completion: nil)
    //            print("userName isempty......")
            return
        }
        if phoneNumPF.text!.isEmpty{
            let alert = UIAlertController(title: "Message", message: " Make sure PhoneNumber must not be blank!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler:nil))
            self.present(alert, animated: true, completion: nil)
    //            print("phone isempty.....")
            return
        }
        if image.isEmpty {
            self.image = login?.image ?? ""
    //            print("Image isEmpty...!== \(self.img)")
        }
        let imgURL = URL(string: image)
        self.imagePF.kf.setImage(with: imgURL)
        self.upDataName = namePF.text!
        self.upDatePhone = phoneNumPF.text!
            print("No Image, Phone and UserName...!")
            print("upDatePhone == \(upDatePhone)")
            print("upDateName == \(upDataName)")
            print("upDateImg == \(image)")
        // put data to aip
        updateProfile()
//        passingData()
        
        return
        
    }// BrnUpdate
    
    //MARK:- all Func
    // func... validate func phoneNumber
    let phoneNumberKit = PhoneNumberKit()
    func isValidatePhone(phone: String) -> Bool {
        do {
            let phoneNumberRegion = try phoneNumberKit.parse(phone, withRegion: "KH")
            print("success === \(phoneNumberRegion)")
            return true
        }
        catch {
//            print(" Generic parser error")
            return false
        }
    }
    // func.. NameValid
    func isValidName(name:String) -> Bool {
        let RegEx = "[a-zA-Z_ ]+"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
//        print("name ==== \(RegEx)")
        return Test.evaluate(with: name)
    }

    //MARK:- Update realm
    func UpdateRealm() {
        let  profile = ProfileUser()
        realm.beginWrite()
        profile._id = userID
        profile.name = upDataName
        profile.phoneNumber = upDatePhone
        profile.image = image
        realm.add(profile)
        try!realm.commitWrite()
//        print(" === New realm ==== \(profile)")
    }
    // func updateProfile
    func updateProfile() {
        
        // cut string url
        let imgs = image.components(separatedBy: "/")
        let cutString = imgs[3]
//        print("cut domain == \(imgs)")
//        print("save index == \(cutString)")
        let params = ["userId": userID ,"name": upDataName, "phoneNumber": upDatePhone,"image":cutString ] as [String : Any]
        let urlStr = "https://coffeetek.herokuapp.com/profile"
        AF.request(urlStr, method: .put, parameters: params as Parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: MessageModel.self) { (response) in
                do {
                    let JSON = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any]
                    print(JSON ?? "")
                } catch {
                    // Your handling code
                }
        
        switch response.result {
        case .success(let response):
            print("SUCCESSS with \(response)")
//            SVProgressHUD.dismiss()
            guard let clearData = self.realm.objects(ProfileUser.self).last else { return  }
            try! self.realm.write {
                self.realm.delete(clearData)
//                        print("delete== ")
            }
            self.UpdateRealm()
            NotificationCenter.default.post(name:NSNotification.Name("MessageReceived"),object: nil)
            
            let alert = UIAlertController(title: "Message", message: response.message, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: {_ in
                self.navigationController?.popViewController(animated: true)
            })
//                    let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel) {
//                        UIAlertAction in
//                        NSLog("Cancel Pressed")
//                    }
            alert.addAction(okAction)
//                    alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
        case .failure(let error):
            print("ERROR with \(error)")
//            SVProgressHUD.dismiss()
            if let data = response.data,
               let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data){
                
                let alert = UIAlertController(title: "Error", message: errorModel.message, preferredStyle: UIAlertController.Style.alert)
//                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
//                        alert.addAction(okAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }// func updateProfle
  
}// updateController

    struct MessageModel: Decodable {
        let message:String
    }
    struct ErrorModel: Decodable {
        let message: String
    //    let statusCode: Int
    }



