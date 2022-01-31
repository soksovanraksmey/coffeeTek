//
//  FloatingPanelControllerViewController.swift
//  CoffeeTek
//
//  Created by ZED on 11/5/21.
//

import UIKit


class ContentController: UIViewController {

    @IBOutlet weak var gotoMenu: UIButton!
    
    @IBOutlet weak var cofeNameText: UILabel!
    @IBOutlet weak var KGmatter: UILabel!
    @IBOutlet weak var locationAddress: UILabel!
    
  
    var callback: (() -> Void)?
    var finalModel: [DataModels] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        gotoMenu.layer.cornerRadius = 22
        
    }
    @IBAction func gotoMenu(_ sender: Any) {
        tabBarController?.tabBar.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let goTo = storyboard.instantiateViewController(withIdentifier: "OrderController")
               self.navigationController?.pushViewController(goTo,animated: true)
        
//        let cell = self.storyboard?.instantiateViewController(withIdentifier: "OrderController")
//        self.navigationController?.pushViewController(cell!, animated: true)
    
    }
    @objc private func addTapped(){
        let rootVC = OrderController()
        let navVC = UINavigationController(rootViewController: rootVC)
        present(navVC, animated: true)
    }
    
   
    
    
}// viewController


