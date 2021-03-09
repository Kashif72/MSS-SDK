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
    
    @IBOutlet weak var tfAmount: CustomTF!
    
    var requestListener : RequestListener? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvTitle.text = obtModel!.product_name!
        tvPRice.text = "Min INR. \(obtModel!.min_price!) Max INR. \(obtModel!.max_price!)"
        tvValidity.text = "Validity \(obtModel!.product_expiry_and_validity!)"
        
        if(obtModel!.product_how_to_use != nil){
            tvHowToUse.attributedText = obtModel!.product_how_to_use.htmlToAttributedString
        }
        
        if(obtModel!.product_description != nil){
            tvDescription.attributedText = obtModel!.product_description.htmlToAttributedString
        }
        
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

        NotificationCenter.default.addObserver(self, selector: #selector(self.onBack(_:)), name: Notification.Name(rawValue: NOTIFICATION_APP_CLOSE), object: nil)
    }
    
    @IBAction func onClickBuyNow(_ sender: Any) {
        if(tfAmount.text!.count == 0){
            tfAmount.errorMessage = ERR_THIS_FILED_IS_REQ
        }else{
            //Show the dialog
            tfAmount.errorMessage = ""
            
            showConfirmDialog(message: "Voucher: \(obtModel!.product_name!)\nAmount:  \(tfAmount.text!)")
        }
        
    }
    
    
    @IBAction func onCLickTNC(_ sender: Any) {
        let podBundle = Bundle(for: GiftTNCVC.self)
        let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
        let controller = storyboard.instantiateViewController(withIdentifier: "GiftTNCVC") as! GiftTNCVC
        controller.modalPresentationStyle = .fullScreen
        controller.tnc = obtModel!.product_terms_conditions!
        self.present(controller, animated: true, completion: nil)
    }
    

    @IBAction func onBackPress(_ sender: Any) {
        dismiss(animated: false)
        
    }
    
    
    func showConfirmDialog(message: String){
        let alert = UIAlertController(title: "Please confirm", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let confirmAction = UIAlertAction(title: "Continue", style: UIAlertAction.Style.default)
        {
            (UIAlertAction) -> Void in
            var req = PayRequest()
            req.amount = self.tfAmount.text!
            req.serviceProvider = self.obtModel!.product_id
            req.accountNumber = ""
            req.transactionType = "giftcard"
            req.amount = self.tfAmount.text!
            //Send data back
            
            self.requestListener?.onRequestMade(request: req)
            self.dismiss(animated: false)
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("didPress cancel")
        }
        
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        
        present(alert, animated: true)
        {
            () -> Void in
        }
    }
    

}
