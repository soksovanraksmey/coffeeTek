//
//  RegisterViewController.swift
//  CoffeeTek
//
//  Created by ZED on 20/4/21.
//

import UIKit
import PhoneNumberKit
import Alamofire
//import SwiftyJSON





class RegisterViewController : UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var Sipnner2: UIActivityIndicatorView!
    @IBOutlet weak var RegisterBtn: UIButton!
    
    @IBOutlet weak var TxtPhoneNum: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var comfirmPass: UITextField!
    
    @IBOutlet weak var invalidPhoneNum: UILabel!
    @IBOutlet weak var invalidPassword: UILabel!
    @IBOutlet weak var invalidComfirm: UILabel!
    
    let phoneNumberKit = PhoneNumberKit()
    
//    let urlRegister =
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHidden()
        self.comfirmPass.delegate = self
        RegisterBtn.layer.cornerRadius = 26.5
        Sipnner2.isHidden = true
        
        
    }
    // drop keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return comfirmPass.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func RegisterBtn1(_ sender: Any) {
        isHidden()
        Sipnner2.isHidden = false
        if validatePhoneNumber(phone: TxtPhoneNum.text!) != true{
            isHidden()
            invalidPhoneNum.isHidden = false
            return
        }else if passWord.text!.count < 6 || passWord.text!.count > 20 {
            isHidden()
            invalidPassword.isHidden = false
            return
        }else if passWord.text!.count != comfirmPass.text!.count{
           isHidden()
            invalidPassword.isHidden = false
            return
        }
        print(DataWithPost())
       
    }

    @IBAction func backBtn (_ sender: Any){
        self.navigationController?.popViewController(animated: true)
        
    }
    // MARK:- validate Password & PhoneNumber
    func validatePhoneNumber(phone: String) -> Bool {
        do{
           
            let phoneNumber = try phoneNumberKit.parse(phone, withRegion: "Kh")
            print("success phoneNumber == \(phoneNumber)")
            return true
           
        }catch{
    
//    print("Generic parser error")
            invalidPhoneNum.isHidden = true
            return false
        }
    }
    
    func isHidden(){
        invalidPhoneNum.isHidden = true
        invalidPassword.isHidden = true
       invalidComfirm.isHidden  = true
    }

// MARK: Data POST
    func DataWithPost (){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newController = storyboard.instantiateViewController(withIdentifier: "loginViewController") as!
        loginViewController
        
        
        let parameter =  ["phone": TxtPhoneNum.text,"password": passWord.text]
        AF.request("https://coffeetek.herokuapp.com/register",
                   method: .post, parameters: parameter,
                   encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ModelMessage.self){ (respones) in
                self.Sipnner2.startAnimating()
                switch respones.result {
                case.success(let respones):
                    let alert = UIAlertController(title: "Message", message: respones.message, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in self.navigationController?.pushViewController(newController, animated: false)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    self.Sipnner2.stopAnimating()
                case .failure(_):
                    if let data = respones.data,
                    let errorModel = try? JSONDecoder().decode(ModelErorr.self, from: data){
                    let alert = UIAlertController(title: "Error", message: errorModel.message, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil ))
                        self.present(alert, animated: true, completion: nil)
                        self.Sipnner2.stopAnimating()
                    }
                }
            }
        }
    
    
}

struct UserNameRegister: Decodable {
    let  phone: String
    let  password: String
    }

struct ModelMessage: Decodable {
    let  message: String
}
struct ModelErorr: Decodable {
    let  message: String
}
