//
//  DTHVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 15/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit
import MBProgressHUD
import TTGSnackbar


class DTHVC: UIViewController, UITextFieldDelegate, OperatorListener   {

    
    @IBOutlet weak var tfDTHNumber: CustomTF!
    @IBOutlet weak var tfServiceProvider: CustomTF!
    @IBOutlet weak var tfAmount: CustomTF!
    
    var serviceCode = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfDTHNumber.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfServiceProvider.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfAmount.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onBack(_:)), name: Notification.Name(rawValue: NOTIFICATION_APP_CLOSE), object: nil)
        
        
    }
    
    
    @IBAction func onBack(_ sender: Any) {
           dismiss(animated: false)
        
    }
    
    
   
    // This will notify us when something has changed on the textfield
       @objc func textFieldDidChange(_ textfield: UITextField) {
           if let text = textfield.text {
            
            switch textfield {
            case tfDTHNumber:
                if(text.count == 0){
                 tfDTHNumber.errorMessage = ERR_THIS_FILED_IS_REQ
                }
                else {
                    // The error message will only disappear when we reset it to nil or empty string
                    tfDTHNumber.errorMessage = ""
                    
                    //Call AutoFetch here
                }
            case tfServiceProvider:
                if(text.count == 0){
                 tfServiceProvider.errorMessage = ERR_THIS_FILED_IS_REQ
                }
                else {
                tfServiceProvider.errorMessage = ""
                }
                
            case tfAmount:
                if(text.count == 0){
                    tfAmount.errorMessage = ERR_THIS_FILED_IS_REQ
                }
                else {
                    tfAmount.errorMessage = ""
                }
            default:
                break
            }
        }
    }
    
    @IBAction func onTouchOperator(_ sender: Any) {
          if(MOperatorModel.dthOptModel.count != 0){
          let podBundle = Bundle(for: GiftCardCatListVC.self)
                         
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            
            let bundle = Bundle(url: bundleURL!)!
            
            let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
            
            let controller = storyboard.instantiateViewController(withIdentifier: "OperatorListVC")
            as! OperatorListVC
            controller.type = "Dth"
            controller.operatorListener = self
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
          }
          else{
              self.showLoading(view: self.view, text: "Please wait")
              
              var req = MOptCircRequest()
              req.topUpType = "DTHBILL"
              
              APIHandler.sharedInstance.getDTHOpt(loginReq: req, success: { (sessionId) in
                  //Success
                self.stopLoading(fromView: self.view)
                let podBundle = Bundle(for: GiftCardCatListVC.self)
                let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
                let bundle = Bundle(url: bundleURL!)!
                let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
                let controller = storyboard.instantiateViewController(withIdentifier: "OperatorListVC") as! OperatorListVC
                controller.type = "dth"
                controller.operatorListener = self
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true, completion: nil)
                  
              }, failure: { (message) in
                  self.stopLoading(fromView: self.view)
                  self.showError(message: message!)
              })
          }
          
      }
    
    
    @IBAction func onClickPay(_ sender: Any) {
        checkField()
       
    }
    
    func checkField (){
            if(tfDTHNumber.text!.count == 0){
                tfDTHNumber.errorMessage = ERR_THIS_FILED_IS_REQ
            }else if (tfServiceProvider.text!.isEmpty){
                tfServiceProvider.errorMessage = ERR_THIS_FILED_IS_REQ
            }else if (tfAmount.text!.isEmpty){
                tfAmount.errorMessage = ERR_THIS_FILED_IS_REQ
            }else{
                //Show the dialog
                clearError()
                showConfirmDialog(message: "DTH Number: \(tfDTHNumber.text!)\nService Provider: \(tfServiceProvider.text!)\n Amount: \(tfAmount.text!)")
            }
        
        
    }
    
    func clearError(){
           tfDTHNumber.errorMessage = ""
           tfServiceProvider.errorMessage = ""
           tfAmount.errorMessage = ""
    }
    
    
    func showConfirmDialog(message: String){
        let alert = UIAlertController(title: "Please confirm", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let confirmAction = UIAlertAction(title: "Continue", style: UIAlertAction.Style.default)
        {
            (UIAlertAction) -> Void in
            var req = PayRequest()
            req.amount = self.tfAmount.text!
            req.accountNumber = self.tfDTHNumber.text!
            req.serviceProvider = self.serviceCode
            req.amount = self.tfAmount.text!
            req.transactionType = "dth"
            //Send data back
            
            
            
            
            
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
    
    
    func onOpSelected(position: Int) {
        print("Selected: \(position)")
        serviceCode = MOperatorModel.dthOptModel[position].code
        tfServiceProvider.text  = MOperatorModel.dthOptModel[position].name
        
    }
     
    
}

