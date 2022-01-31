//
//  OrderTableViewCellController.swift
//  CoffeeTek
//
//  Created by ZED on 7/5/21.
//

import UIKit
//import Alamofire



class OrderTableViewCellController: UITableViewCell {
  
    @IBOutlet  weak var imageCup: UIImageView!
    @IBOutlet weak var NameImage: UILabel!
   
//   var photo : PhotoMenu! {
//        didSet{
//            self.NameImage.text = self.photo.name
//            self.imageCup.setImage(imgUrl: self.photo.image)
//
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    @IBAction func nextbutton(_ sender: Any) {

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK:- get image prom API
//    func getimage(){
//
//        let parameter =  ["image": imageCup.image,"name": NameImage.text]
//        AF.request("https://coffeetek.herokuapp.com/menu",
//                   method: .post, parameters: parameter,
//                   encoder: JSONParameterEncoder.default)
//    }
    
}

