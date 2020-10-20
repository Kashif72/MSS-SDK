//
//  DashboardVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 02/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit


class DashboardVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RequestListener {
    
    
    @IBOutlet weak var cvMenu: UICollectionView!
    
    let menuItems = StaticData.getHomeMenu()
    
    
    var requestListener : RequestListener? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cvMenu.dataSource = self
        self.cvMenu.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onBack(_:)), name: Notification.Name(rawValue: NOTIFACTION_REQUEST), object: nil)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    @objc func closeVC(_ notification: NSNotification) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func onBack(_ sender: Any) {
        print("Close","Calledasasas")
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
            let podBundle = Bundle(for: MobileRechargeVC.self)
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            let bundle = Bundle(url: bundleURL!)!
            let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
            let controller = storyboard.instantiateViewController(withIdentifier: "MobileRechargeVC") as! MobileRechargeVC
            controller.modalPresentationStyle = .fullScreen
            controller.requestListener = self
            self.present(controller, animated: true, completion: nil)
            
            
        case 1:
            let podBundle = Bundle(for: DTHVC.self)
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            let bundle = Bundle(url: bundleURL!)!
            let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
            let controller = storyboard.instantiateViewController(withIdentifier: "DTHVC") as! DTHVC
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
            
        case 3:
            let podBundle = Bundle(for: NewsVC.self)
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            let bundle = Bundle(url: bundleURL!)!
            let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
            let controller = storyboard.instantiateViewController(withIdentifier: "NewsVC") as! NewsVC
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
            
            
        case 4:
            let podBundle = Bundle(for: BusSearchVC.self)
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            let bundle = Bundle(url: bundleURL!)!
            let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
            let controller = storyboard.instantiateViewController(withIdentifier: "BusSearchVC") as! BusSearchVC
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
            
        case 2:
            let podBundle = Bundle(for: GiftCardCatListVC.self)
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            let bundle = Bundle(url: bundleURL!)!
            let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
            let controller = storyboard.instantiateViewController(withIdentifier: "GiftCardCatListVC") as! GiftCardCatListVC
            controller.modalPresentationStyle = .fullScreen
            controller.giftCatrequestListener = self
            self.present(controller, animated: true, completion: nil)
            
        case 8:
            let podBundle = Bundle(for: WebViewVC.self)
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            let bundle = Bundle(url: bundleURL!)!
            let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
            let controller = storyboard.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
            controller.modalPresentationStyle = .fullScreen
            controller.webUrl = "http://bigbasket.go2cloud.org/aff_c?offer_id=271&aff_id=3683"
            self.present(controller, animated: true, completion: nil)
            
        default:
            break
        }
            
            
        }
    
    func onRequestMade(request: PayRequest) {
//        requestListener?.onRequestMade(request: request)

        let reqDataDict:[String: PayRequest] = [REQUEST_DATA: request]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFACTION_REQUEST), object: nil, userInfo: reqDataDict)
        dismiss(animated: false)
    }
    
}


class CellHomeMenu: UICollectionViewCell {
    @IBOutlet weak var ivMenu: UIImageView!
    @IBOutlet weak var tvMenu: UILabel!
    @IBOutlet weak var consWidth: NSLayoutConstraint!
    @IBOutlet weak var conHeight: NSLayoutConstraint!
    
    
    func load(items: MenuModel) {
        let screenWidth = UIScreen.main.bounds.size.width
        consWidth.constant = (screenWidth/3) - 8
        conHeight.constant = (screenWidth/3)
        
        let podBundle = Bundle(for: DashboardVC.self)
        let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        let img = UIImage(named: items.image, in: bundle, compatibleWith: nil)
        ivMenu.image = img
        tvMenu.text = items.title
        
    }
}



protocol RequestListener {
    func onRequestMade(request: PayRequest)
}
