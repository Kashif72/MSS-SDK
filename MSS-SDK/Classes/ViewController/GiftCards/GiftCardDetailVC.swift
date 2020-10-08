//
//  GiftCardDetailVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 07/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit

class GiftCardDetailVC: UIViewController {

    
    @IBOutlet weak var ivGift: UIImageView!
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvPRice: UILabel!
    @IBOutlet weak var tvHowToUse: UILabel!
    @IBOutlet weak var tvValidity: UILabel!
    @IBOutlet weak var tvDescription: UILabel!
    @IBOutlet weak var avImage: UIActivityIndicatorView!
    
    var obtModel : GiftCardModel?  = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (obtModel!.product_image != nil && obtModel!.product_image.count > 0) {
            let finalImagePath =  obtModel!.product_image
            let urlString = finalImagePath!.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            let url = URL(string:urlString!)
            let imageRequest = URLRequest.init(url:url!)
            ivGift.af.setImage(withURLRequest: imageRequest, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false, completion: { (image) in
                self.avImage.stopAnimating()
                self.avImage.isHidden = true
            })
            
        }else{
            self.avImage.stopAnimating()
            self.avImage.isHidden = true
            let podBundle = Bundle(for: GiftCardDetailVC.self)
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            let bundle = Bundle(url: bundleURL!)!
            let imageNotFound = UIImage(named: "img_not_found", in: bundle, compatibleWith: nil)
            
            self.ivGift.image = imageNotFound
            self.ivGift.contentMode = .center
            
            
        }

    }
    
    

    @IBAction func onBackPress(_ sender: Any) {
        dismiss(animated: false)
        
    }
    

}
