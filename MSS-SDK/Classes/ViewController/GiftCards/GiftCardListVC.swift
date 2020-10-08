//
//  GiftCardListVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 07/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit
import MBProgressHUD
import TTGSnackbar
import AlamofireImage

class GiftCardListVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tvGiftCard: UITableView!
    
    var giftArray = GiftCardModel.giftCardListInstance
    
    var voucherId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvGiftCard.delegate = self
        tvGiftCard.dataSource = self
        
        if(giftArray.count ==  0){
            let gifCardListReq = GiftCardListRequest(voucher_id: voucherId)
            
            self.showLoading(view: self.view, text: "Please wait")
            
           APIHandler.sharedInstance.getGiftCardList(loginReq: gifCardListReq, success: { (sessionId) in
                      //Success
                      
            self.stopLoading(fromView: self.view)
            self.giftArray = GiftCardModel.giftCardListInstance
            self.tvGiftCard.reloadData()
            
            
            }, failure: { (message) in
                      self.stopLoading(fromView: self.view)
                      self.showError(message: message!)
            })
           
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
           print("noOfSection")
           return 1
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return giftArray.count
       }
       
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "GiftListCell", for: indexPath) as! GiftListCell
        
           cell.lblTitle?.text = giftArray[indexPath.row].product_name
          
        
           if (giftArray[indexPath.row].product_image != nil && giftArray[indexPath.row].product_image.count > 0) {
                   
            let finalImagePath =  giftArray[indexPath.row].product_image!
                   
                   print("finalImagePathCat", finalImagePath)
                   let urlString = finalImagePath.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
                   
                   
                   let url = URL(string:urlString!)
                   let imageRequest = URLRequest.init(url:url!)
                   cell.ivImage.af.setImage(withURLRequest: imageRequest, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false, completion: { (image) in
                       cell.avCell.stopAnimating()
                       cell.avCell.isHidden = true
                   })
               }else{
                   cell.avCell.stopAnimating()
                   cell.avCell.isHidden = true
                   cell.ivImage.image = #imageLiteral(resourceName: "img_not_found")
                   cell.ivImage.contentMode = .center
                   
               }
           return cell
       }
  
    
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
       {
           return 200
       }
       
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let podBundle = Bundle(for: GiftCardCatListVC.self)
           let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
           let bundle = Bundle(url: bundleURL!)!
           let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
           let controller = storyboard.instantiateViewController(withIdentifier: "GiftCardDetailVC") as! GiftCardDetailVC
            controller.obtModel = giftArray[indexPath.row]
           controller.modalPresentationStyle = .fullScreen
           self.present(controller, animated: true, completion: nil)
        
       }
    
    
    func showError(message: String){
          let snackbar = TTGSnackbar(message: message, duration: .short)
          snackbar.animationType = .slideFromTopBackToTop
          snackbar.backgroundColor = ColorConverter.hexStringToUIColor(hex: ColorCode.txtError)
          snackbar.show()
      }
    
    
    private func showLoading(view:UIView, text:String){
          let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
          loadingNotification.mode = MBProgressHUDMode.indeterminate
      }
      
      
      private func stopLoading(fromView:UIView){
          MBProgressHUD.hide(for: fromView, animated: true)
      }
    
    
    @IBAction func onBack(_ sender: Any) {
           dismiss(animated: false)
       
    }

}


class GiftListCell: UITableViewCell{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblValidaity: UILabel!
    @IBOutlet weak var avCell: UIActivityIndicatorView!
    
    
}
