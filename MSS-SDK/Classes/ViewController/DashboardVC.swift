//
//  DashboardVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 02/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit


class DashboardVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var cvMenu: UICollectionView!
    
    let menuItems = StaticData.getHomeMenu()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cvMenu.dataSource = self
        self.cvMenu.delegate = self
        
    }
    
    
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: false)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return  menuItems.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = cvMenu.dequeueReusableCell(withReuseIdentifier: "CellHomeMenu", for: indexPath as IndexPath) as! CellHomeMenu
            
            cell.load(items: menuItems[indexPath.row])
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        
        case 0:
            let podBundle = Bundle(for: GiftCardCatListVC.self)
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            let bundle = Bundle(url: bundleURL!)!
            let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
            let controller = storyboard.instantiateViewController(withIdentifier: "MobileRechargeVC") as! MobileRechargeVC
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
            
            
        case 1:
//            let podBundle = Bundle(for: GiftCardCatListVC.self)
//            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
//            let bundle = Bundle(url: bundleURL!)!
//            let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
//            let controller = storyboard.instantiateViewController(withIdentifier: "MobileRechargeVC") as! MobileRechargeVC
//            controller.modalPresentationStyle = .fullScreen
//            self.present(controller, animated: true, completion: nil)
            
        case 2:
            let podBundle = Bundle(for: GiftCardCatListVC.self)
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            let bundle = Bundle(url: bundleURL!)!
            let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
            let controller = storyboard.instantiateViewController(withIdentifier: "GiftCardCatListVC") as! GiftCardCatListVC
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
            
        default:
            break
        }
            
            
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: (collectionView.frame.width/3), height: (collectionView.frame.width/3))
       }
    
    
   
    
}



class CellHomeMenu: UICollectionViewCell {
    
    @IBOutlet weak var ivMenu: UIImageView!
    @IBOutlet weak var tvMenu: UILabel!
    
    
    func load(items: MenuModel) {
        ivMenu.image = items.image
        tvMenu.text = items.title
        
    }
}
