//
//  MobileRechargeVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 06/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit
import MBProgressHUD
import TTGSnackbar


class MobileRechargeVC: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, OperatorListener   {

    
    @IBOutlet weak var tfMobile: CustomTF!
    @IBOutlet weak var tfServiceProvider: CustomTF!
    
    @IBOutlet weak var tfArea: CustomTF!
    @IBOutlet weak var tfAmount: CustomTF!
    
    var isPlan : Bool = false
    
    var serviceCode = ""
    var areaCode = ""
    
    
    let areaPV = UIPickerView()
    var areaArray = MCircleModel.preCircleModel
    
    var requestListener : RequestListener? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfMobile.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged);
        tfServiceProvider.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged);
        tfArea.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged);
        tfAmount.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged);
        
        self.areaPV.delegate = self
        self.tfArea.inputView = self.areaPV
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onBack(_:)), name: Notification.Name(rawValue: NOTIFICATION_APP_CLOSE), object: nil)
        
    }
    
    
    @IBAction func onBack(_ sender: Any) {
           dismiss(animated: false)
        
    }
    
    
    @IBAction func onClickPlans(_ sender: Any) {
        isPlan = true
        checkField()
        
    }
   
    // This will notify us when something has changed on the textfield
       @objc func textFieldDidChange(_ textfield: UITextField) {
           if let text = textfield.text {
            
            switch textfield {
            case tfMobile:
                if(text.count == 0){
                 tfMobile.errorMessage = ERR_THIS_FILED_IS_REQ
                }
                else if(text.count < 10) {
                    tfMobile.errorMessage = ERR_MOBILE
                }
                else {
                    // The error message will only disappear when we reset it to nil or empty string
                    tfMobile.errorMessage = ""
                    
                    //Call AutoFetch here
                }
            case tfServiceProvider:
                if(text.count == 0){
                 tfServiceProvider.errorMessage = ERR_THIS_FILED_IS_REQ
                }
                else {
                tfServiceProvider.errorMessage = ""
                }
                
            case tfArea:
                if(text.count == 0){
                    tfArea.errorMessage = ERR_THIS_FILED_IS_REQ
                }
                else {
                    tfArea.errorMessage = ""
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
          if(MOperatorModel.preOptModel.count != 0){
          let podBundle = Bundle(for: GiftCardCatListVC.self)
                         
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            
            let bundle = Bundle(url: bundleURL!)!
            
            let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
            
            let controller = storyboard.instantiateViewController(withIdentifier: "OperatorListVC")
            as! OperatorListVC
            controller.type = "Pre"
            controller.operatorListener = self
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
          }
          else{
              self.showLoading(view: self.view, text: "Please wait")
              
              var req = MOptCircRequest()
              req.topUpType = "PRE"
            APIHandler.sharedInstance.getOptCircle(loginReq: req, success: { (sessionId) in
                    //Success
            self.stopLoading(fromView: self.view)
            let podBundle = Bundle(for: GiftCardCatListVC.self)
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            let bundle = Bundle(url: bundleURL!)!
            let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
            let controller = storyboard.instantiateViewController(withIdentifier: "OperatorListVC") as! OperatorListVC
            controller.type = "Pre"
            controller.operatorListener = self
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
                    
                }, failure: { (message) in
                    self.stopLoading(fromView: self.view)
                    self.showError(message: message!)
                })
            
          }
          
      }
    
    @IBAction func onTouchCircle(_ sender: Any) {
        if(areaArray.count != 0){
        
        }
        else{
            self.showLoading(view: self.view, text: "Please wait")
            
            var req = MOptCircRequest()
            req.topUpType = "PRE"
            
            APIHandler.sharedInstance.getOptCircle(loginReq: req, success: { (sessionId) in
                //Success
                self.stopLoading(fromView: self.view)
                self.areaArray = MCircleModel.preCircleModel
                self.areaPV.reloadAllComponents()
                
            }, failure: { (message) in
                self.stopLoading(fromView: self.view)
                self.showError(message: message!)
            })
        }
        
    }
    
    
    @IBAction func onClickPay(_ sender: Any) {
        isPlan = false
        checkField()
       
    }
    
    func checkField (){
        if(!isPlan){
            if(tfMobile.text!.count == 0){
                tfMobile.errorMessage = ERR_THIS_FILED_IS_REQ
            }else if (tfMobile.text!.count < 10){
                tfMobile.errorMessage = ERR_MOBILE
            }else if (tfServiceProvider.text!.isEmpty){
                tfServiceProvider.errorMessage = ERR_THIS_FILED_IS_REQ
            }else if (tfArea.text!.isEmpty){
                tfArea.errorMessage = ERR_THIS_FILED_IS_REQ
            }else if (tfAmount.text!.isEmpty){
                tfAmount.errorMessage = ERR_THIS_FILED_IS_REQ
            }else{
                //Show the dialog
                clearError()
                showConfirmDialog(message: "Mobile: \(tfMobile.text!)\nService Provider: \(tfServiceProvider.text!)\n Area: \(tfArea.text!)\n Amount: \(tfAmount.text!)")
            }
        }else{
            if (tfServiceProvider.text!.isEmpty){
                tfServiceProvider.errorMessage = ERR_THIS_FILED_IS_REQ
            }else if (tfArea.text!.isEmpty){
                tfArea.errorMessage = ERR_THIS_FILED_IS_REQ
            }else{
                clearError()
                let podBundle = Bundle(for: GiftCardCatListVC.self)
                let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
                let bundle = Bundle(url: bundleURL!)!
                let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
                let controller =
                    storyboard.instantiateViewController(withIdentifier: "MobilePlanVC")
                         as! MobilePlanVC
                controller.circleCode = areaCode
                controller.opCode = serviceCode
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true, completion: nil)
                
            }
        }
        
    }
    
    func clearError(){
           tfMobile.errorMessage = ""
           tfServiceProvider.errorMessage = ""
           tfArea.errorMessage = ""
           tfAmount.errorMessage = ""
    }
    
    
    func showConfirmDialog(message: String){
        let alert = UIAlertController(title: "Please confirm", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let confirmAction = UIAlertAction(title: "Continue", style: UIAlertAction.Style.default)
        {
            (UIAlertAction) -> Void in
            
            
            var req = PayRequest()
            req.amount = self.tfAmount.text!
            req.accountNumber = self.tfMobile.text!
            req.serviceProvider = self.serviceCode
            req.transactionType = "prepaid"
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
    
    
    //Picker
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return areaArray.count
            
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if(tfArea.text?.count == 0){
                tfArea.text = areaArray[row].name
                areaCode = areaArray[row].code
                tfArea.errorMessage = ""
            }
                return areaArray[row].name
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            tfArea.errorMessage = ""
            if(areaArray.count > 0){
                tfArea.text = areaArray[row].name
                areaCode = areaArray[row].code
                tfArea.errorMessage = ""
            }
        }
    
    func onOpSelected(position: Int) {
        print("Selected: \(position)")
        serviceCode = MOperatorModel.preOptModel[position].code
        tfServiceProvider.text  = MOperatorModel.preOptModel[position].name
        
    }
     
    
}



protocol OperatorListener {
    func onOpSelected(position: Int)
}
