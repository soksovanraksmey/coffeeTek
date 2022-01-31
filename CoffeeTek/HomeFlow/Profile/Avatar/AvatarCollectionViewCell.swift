//
//  AvataorCollectionCollectionViewCell.swift
//  CoffeeTek
//
//  Created by ZED on 20/5/21.
//

import UIKit

class AvatarCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var checkImg: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkImg.layer.cornerRadius = 30
        // Initialization code
    }

}
