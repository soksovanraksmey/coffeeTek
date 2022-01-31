//
//  PreferenceController.swift
//  CoffeeTek
//
//  Created by ZED on 10/5/21.
//

import UIKit


class PreferenceController: UIViewController {
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var SubtractBtn: UIButton!
    @IBOutlet weak var AddCartBtn: UIButton!
    
    @IBOutlet weak var LblNamecofe: UILabel!
    @IBOutlet weak var LblNumCofe: UILabel!
    @IBOutlet weak var lalTotal: UILabel!
    //imagecup
    @IBOutlet weak var ImageCup: UIImageView!
    
    
    // choose size of cup
    @IBOutlet weak var smallCup: UIButton!
    @IBOutlet weak var bigCup: UIButton!
    @IBOutlet weak var MediumCup: UIButton!
    //choose Sugar
    @IBOutlet weak var sugar100: UIButton!
    @IBOutlet weak var sugar75: UIButton!
    @IBOutlet weak var sugar50: UIButton!
    @IBOutlet weak var noSugar: UIButton!
    //Addittions
    
    @IBOutlet weak var addgrimLbl: UIButton!
    
    var nameCofe = ""
    var priceCofe: Float = 0.0
    var dataModel: PhotoMenu1? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //MARK:- image kingfisher
        LblNamecofe.text = nameCofe
        if let data = dataModel{
            let imgURL = URL(string: data.image)
            self.ImageCup.kf.setImage(with: imgURL)
            self.priceCofe = Float(data.price)
            lalTotal.text = "\(String(priceCofe))"
        }
        
//        self.tabBarController?.tabBar.isHidden = true
        
        navigationController?.isNavigationBarHidden = false
        let lble1 = UILabel()
        lble1.text = "Preference"
        navigationItem.titleView = lble1
        lble1.textColor = .brown
        
        // style btn
        plusBtn.layer.cornerRadius = 15
        plusBtn.layer.maskedCorners =  [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        plusBtn.layer.borderColor = UIColor.black.cgColor
        plusBtn.layer.borderWidth = 2
        
        SubtractBtn.layer.cornerRadius = 15
        SubtractBtn.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        SubtractBtn.layer.borderColor = UIColor.black.cgColor
        SubtractBtn.layer.borderWidth = 2
        
        AddCartBtn.layer.cornerRadius = 20
    }
    //MARK:- Button Cup
    @IBAction func smallCup(_ sender: Any) {
    clearImageCup()
        smallCup.setImage(UIImage(named: "icons8-kawaii-coffee-50"), for: .normal)
    }
    @IBAction func bigCup(_ sender: Any) {
       clearImageCup()
        bigCup.setImage(UIImage(named: "icons8-kawaii-coffee-50"), for: .normal)
    }
    @IBAction func MediumCup(_ sender: Any) {
        clearImageCup()
        MediumCup.setImage(UIImage(named: "icons8-kawaii-coffee-50"), for: .normal)
    }
    //btn sugar
    @IBAction func nosugar(_ sender: Any) {
    clearImageSugar()
        noSugar.setImage(UIImage(named: "icons8-sugar-free-32 (1)"), for: .normal)
    }
    @IBAction func sugar50(_ sender: Any) {
       clearImageSugar()
            sugar50.setImage(UIImage(named: "icons8-sugar-cube-32 (1)"), for: .normal)
    }
    @IBAction func sugar75(_ sender: Any) {
        clearImageSugar()
            sugar75.setImage(UIImage(named: "icons8-sugar-free-32 (1)"), for: .normal)
    }
    @IBAction func sugar100(_ sender: Any) {
       clearImageSugar()
            sugar100.setImage(UIImage(named: "icons8-sugar-cubes-32 (1)"), for: .normal)
    }
    
    @IBAction func addGrimBtn(_ sender: Any) {
        clearGrimImage()
            addgrimLbl.setImage(UIImage(named: "IMAGE 2021-05-17 07:27:03"), for: .normal)
    }
    // MARK:- Add number of cup
    @IBAction func addBtn(_ sender: Any) {
        let addNumber = LblNumCofe.text!
        guard let numberCup = Int(addNumber) else{
            return
        }
        let  numberOfCup = numberCup + 1
        let total = Float( numberOfCup) * (Float(priceCofe))
        LblNumCofe.text = "\(numberOfCup)"
        lalTotal.text = "\(total)"
        
    }
    //MARK:- subtrac of cup
    @IBAction func SubtracBtn(_ sender: Any) {
        let addNumber = LblNumCofe.text!
        guard let numberCup = Int(addNumber) else{
            return
        }
        let  numberOfCup = numberCup - 1
        let total = Float( numberOfCup) * (Float(priceCofe))
        LblNumCofe.text = "\(numberOfCup)"
        lalTotal.text = "\(total)"
    }
    
    func clearImageCup(){
        smallCup.setImage(UIImage(named: ""), for: .normal)
        MediumCup.setImage(UIImage(named: ""), for: .normal)
        bigCup.setImage(UIImage(named: ""), for: .normal)
  
    }
    func clearImageSugar() {
        noSugar.setImage(UIImage(named: ""), for: .normal)
        sugar50.setImage(UIImage(named: ""), for: .normal)
        sugar75.setImage(UIImage(named: ""), for: .normal)
        sugar100.setImage(UIImage(named: ""), for: .normal)
    }
    func clearGrimImage(){
        addgrimLbl.setImage(UIImage(named: ""), for: .normal)
    }
}
