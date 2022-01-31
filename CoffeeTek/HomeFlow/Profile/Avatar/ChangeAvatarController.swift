//
//  ChangeAvatarController.swift
//  CoffeeTek
//
//  Created by ZED on 20/5/21.
//


import UIKit
import Alamofire
import Kingfisher


class ChangeAvatarController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ViewBrown: UIView!

    var callback: ((String?)->())?
    var avatar = [String]()
    var indexSelect: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        ViewBrown.layer.cornerRadius = 20
        ViewBrown.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        collectionView.layer.cornerRadius = 10

        collectionView.layer.shadowOpacity = 1
        collectionView.layer.shadowOffset = .zero
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowRadius = 10
        
        let nib = UINib(nibName: "AvatarCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "AvatarCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
       
        getAvatar()
        
    }
    // MARK:- Data Avatar
    private func getAvatar(){
         
        let request = AF.request("https://coffeetek.herokuapp.com/avatar")
        request.responseDecodable(of: [String].self) { (response) in
            guard let films = response.value else{
                return
            }
            self.avatar = films
            self.collectionView.reloadData()
            print("image \(self.avatar)")
        }
       
    }
    
    

    // MARK:- CollectionView func
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCollectionViewCell", for: indexPath) as! AvatarCollectionViewCell
        
        let model = avatar[indexPath.row]
        let imgURL = URL(string: model)
        cell.avatarImage.kf.setImage(with: imgURL)
        cell.checkImg.tag = indexPath.row
        cell.checkImg.addTarget(self, action: #selector(handTap(sender:)), for: .touchUpInside)
        if indexSelect == indexPath.row{
          
            cell.checkImg.alpha = 0.8
            let imgUrl = URL(string: model)
            cell.avatarImage.kf.setImage(with: imgUrl)
        }else{
           
            cell.checkImg.alpha = 0.1
            let imgUrl = URL(string: model)
            cell.avatarImage.kf.setImage(with: imgUrl)
        }
        
        return cell
        
    }
    @objc func handTap(sender: UIButton){
        indexSelect = sender.tag
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width/3.0 - 8,
                      height: collectionView.frame.size.width/3.0 - 8)
    }
    
    
    @IBAction func confirmBtn(_ sender: Any) {
        callback?(avatar[indexSelect])
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func BackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
