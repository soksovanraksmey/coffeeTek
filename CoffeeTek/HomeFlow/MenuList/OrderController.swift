//
//  OrderController.swift
//  CoffeeTek
//
//  Created by ZED on 6/5/21.
//

import UIKit
import Kingfisher
import Alamofire

//struct MyProdouct {
//    var name: String!
//    var image: UIImage!
//
//init(name: String,image: UIImage){
//    self.name = name
//    self.image = image
//    }
//}
struct PhotoMenu1: Decodable{
  let _id : String
  let  name : String
  let image : String
  let price : Double
  let status: Int
  let  __v : Int

  }


class OrderController: UIViewController,UITableViewDelegate,UITableViewDataSource{
   
   // var url = "https://coffeetek.herokuapp.com/menu"

    let nameCofe:String! = nil
    let imageCofe:UIImage! = nil
    let priceCofe: Double! = nil
    
    
    @IBOutlet weak var tableView: UITableView!
//    var prodouctList = [MyProdouct]()
    
     var photos: [PhotoMenu1] = []
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // navigation
        navigationController?.isNavigationBarHidden = false
        let lble1 = UILabel()
        lble1.text = "Stabuck"
        lble1.textColor = .brown
        navigationItem.titleView = lble1
        self.tabBarController?.tabBar.isHidden = false
        // register nib
        let nib = UINib(nibName: "OrderTableViewCellController", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "OrderTableViewCellController")
        
        // table delegate
        tableView.delegate = self
        tableView.dataSource = self
        fetchData()
//        prodouctList = [MyProdouct(name: "Espresso", image: #imageLiteral(resourceName: "icons8-cafe-400"))
//                        ,MyProdouct(name: "Cappuccino", image: #imageLiteral(resourceName: "icons8-espresso-cup-256"))
//                        ,MyProdouct(name: "Macciato", image: #imageLiteral(resourceName: "Macciato"))
//                        ,MyProdouct(name: "Mocha", image: #imageLiteral(resourceName: "Mocha"))
//                        ,MyProdouct(name: "Latte", image: #imageLiteral(resourceName: "latte 2"))]
            
        
    }

    @objc func addTapped(sender: AnyObject) {
    print("hjxdbsdhjbv")
}
    // MARK:- fetchData
    private func fetchData(){
//        AF.request(self.url + "/photo", method: .get).responseDecodable(of: [PhotoMenu1].self) { [weak self] (response) in
//            self?.photos = response.value ?? []
//            self?.tableView.reloadData()
//            print("succsec data")
         
        let request = AF.request("https://coffeetek.herokuapp.com/menu")
        request.responseDecodable(of: [PhotoMenu1].self) { (response) in
            guard let films = response.value else{
                return
            }
            self.photos = films
            self.tableView.reloadData()
            print("\(response)")
        }
        
        
        }
    
//    func setImage(imgUrl: String){
//        self.kf.setImage(with: URL(string: imgUrl ))
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCellController", for: indexPath) as? OrderTableViewCellController {
            
            let model = photos[indexPath.row]
            let imgURL = URL(string: model.image)
            cell.imageCup.kf.setImage(with: imgURL)
            cell.NameImage.text = model.name

           // cell.photo = self.photos[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let VC = storyboard?.instantiateViewController(withIdentifier: "PreferenceController") as? PreferenceController{
            self.navigationController?.pushViewController(VC, animated: true)
            
            let models = photos[indexPath.row]
            VC.nameCofe = models.name
            VC.dataModel = models
            
            
        }
    }  
    
}


