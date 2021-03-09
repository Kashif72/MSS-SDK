//
//  OperatorListVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 14/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit

class OperatorListVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var cvOperator: UICollectionView!
    
    
    var operatorItems = Array<MOperatorModel>()
    
    var type = ""
    
    var operatorListener : OperatorListener? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(type == "Pre"){
            operatorItems = MOperatorModel.preOptModel
        }else{
            operatorItems = MOperatorModel.dthOptModel
        }
        self.cvOperator.dataSource = self
        self.cvOperator.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onClickBack(_:)), name: Notification.Name(rawValue: NOTIFICATION_APP_CLOSE), object: nil)
        
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
            
            
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  operatorItems.count
    
    }
            
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvOperator.dequeueReusableCell(withReuseIdentifier: "OperatorCell", for: indexPath as IndexPath) as! OperatorCell
        cell.load(items: operatorItems[indexPath.row])
        return cell
    
    }
        
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        operatorListener?.onOpSelected(position: indexPath.row)
        dismiss(animated: false)
        
    }
    
    @IBAction func onClickBack(_ sender: Any) {
          dismiss(animated: false)
        
        }
    }


class OperatorCell: UICollectionViewCell{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var avCell: UIActivityIndicatorView!
    
    @IBOutlet weak var consWidth: NSLayoutConstraint!
    @IBOutlet weak var conHeight: NSLayoutConstraint!
    
    
    func load(items: MOperatorModel) {
        let screenWidth = UIScreen.main.bounds.size.width
        consWidth.constant = (screenWidth/2) - 8
        conHeight.constant = (screenWidth/2)
        lblTitle.text = items.name
        
        if (items.serviceLogo != nil && items.serviceLogo.count > 0) {
            let finalImagePath =  items.serviceLogo!
            let urlString = finalImagePath.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            let url = URL(string:urlString!)
            let imageRequest = URLRequest.init(url:url!)
        
            ivImage.af.setImage(withURLRequest: imageRequest, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false, completion: { (image) in
            
                self.avCell.stopAnimating()
                
                self.avCell.isHidden = true
            })
        }else{
            avCell.stopAnimating()
            avCell.isHidden = true
            let podBundle = Bundle(for: GiftCardDetailVC.self)
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            let bundle = Bundle(url: bundleURL!)!
            let imageNotFound = UIImage(named: "img_not_found", in: bundle, compatibleWith: nil)
            ivImage.image = imageNotFound
            ivImage.contentMode = .center
        }
        
    }
    
    
}
