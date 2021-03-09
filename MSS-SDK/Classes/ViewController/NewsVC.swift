//
//  NewsVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 15/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit
import MBProgressHUD
import TTGSnackbar
import AlamofireImage

class NewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tblNews: UITableView!
    
    var newsArray = NewsModel.newsListInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblNews.delegate = self
        tblNews.dataSource = self
        
        if(newsArray.count ==  0){
            self.showLoading(view: self.view, text: "Please wait")
            APIHandler.sharedInstance.getNewsList(success: { (response) in
                       //Success
                self.stopLoading(fromView: self.view)
                self.newsArray = NewsModel.newsListInstance
                
                self.tblNews.reloadData()
                       
                }, failure: { (message) in
                    self.stopLoading(fromView: self.view)
                    self.showError(message: message!)
                })
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onBack(_:)), name: Notification.Name(rawValue: NOTIFICATION_APP_CLOSE), object: nil)
    }
    
    @IBAction func onBack(_ sender: Any) {
          print("Close","Calledasasas")
          dismiss(animated: false)
      
      }
    
    func numberOfSections(in tableView: UITableView) -> Int {
              print("noOfSection")
              return 1
          }
          
          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return newsArray.count
          }
          
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath) as! NewsListCell
              cell.lblTitle?.text = newsArray[indexPath.row].title
                cell.lblDate.text = newsArray[indexPath.row].publishedAt
            cell.lblDescription.text = newsArray[indexPath.row].description
             
              if (newsArray[indexPath.row].urlToImage != nil && newsArray[indexPath.row].urlToImage.count > 0) {
                      let finalImagePath =  newsArray[indexPath.row].urlToImage!
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
                      
                       let podBundle = Bundle(for: GiftCardDetailVC.self)
                       let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
                       let bundle = Bundle(url: bundleURL!)!
                       let imageNotFound = UIImage(named: "img_not_found", in: bundle, compatibleWith: nil)
                       cell.ivImage.image = imageNotFound
                       cell.ivImage.contentMode = .center
                      
                  }
              
           
           
              
              
              return cell
          }
          
          func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
          {
              return 220
          }
          
          
          func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let podBundle = Bundle(for: NewsVC.self)
                         let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
                         let bundle = Bundle(url: bundleURL!)!
                         let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
                         let controller = storyboard.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
                         controller.modalPresentationStyle = .fullScreen
            controller.webUrl = newsArray[indexPath.row].url
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
       

    
    @IBAction func onClickBack(_ sender: Any) {
            dismiss(animated: false)
    }

}


class NewsListCell: UITableViewCell{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var avCell: UIActivityIndicatorView!
    
    
    
}
