//
//  BusSearchVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 16/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit
import MBProgressHUD
import TTGSnackbar


class BusSearchVC: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate   {

    
    @IBOutlet weak var tfFrom: CustomTF!
    
    @IBOutlet weak var tfTo: CustomTF!
    @IBOutlet weak var tfDate: CustomTF!
    
    var fromCityCode = ""
    var toCityCode = ""
    var fromCityName = ""
    var toCityName = ""
    
    
    let fromPv = UIPickerView()
    let toPv = UIPickerView()
    var cityArray = BusCityModel.busCityInstance
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfFrom.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfTo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfDate.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.fromPv.delegate = self
        self.toPv.delegate = self
        self.tfFrom.inputView = self.fromPv
        self.tfTo.inputView = self.toPv
        
        
    }
    
    
    @IBAction func onBack(_ sender: Any) {
           dismiss(animated: false)
        
    }
    
    
    // This will notify us when something has changed on the textfield
       @objc func textFieldDidChange(_ textfield: UITextField) {
           if let text = textfield.text {
            
            switch textfield {
            case tfFrom:
                if(text.count == 0){
                 tfFrom.errorMessage = ERR_THIS_FILED_IS_REQ
                }
                else {
                    tfFrom.errorMessage = ""
                    
                }
            case tfTo:
                if(text.count == 0){
                 tfTo.errorMessage = ERR_THIS_FILED_IS_REQ
                }
                else {
                tfTo.errorMessage = ""
                }
                
            case tfDate:
                if(text.count == 0){
                    tfDate.errorMessage = ERR_THIS_FILED_IS_REQ
                }
                else {
                    tfDate.errorMessage = ""
                }
            default:
                break
            }
        }
    }
    
    
    @IBAction func onTouchCircle(_ sender: Any) {
        if(cityArray.count != 0){
        
        }
        else{
            self.showLoading(view: self.view, text: "Please wait")
            
            var req = MOptCircRequest()
            req.topUpType = "PRE"
            
            APIHandler.sharedInstance.getBusCity(success: { (sessionId) in
                //Success
                self.stopLoading(fromView: self.view)
                self.cityArray = BusCityModel.busCityInstance
                self.fromPv.reloadAllComponents()
                self.toPv.reloadAllComponents()
                
                
            }, failure: { (message) in
                self.stopLoading(fromView: self.view)
                self.showError(message: message!)
            })
        }
        
    }
    
    
    @IBAction func onClickSearch(_ sender: Any) {
        checkField()
       
    }
    
    func checkField (){
            if(tfFrom.text!.count == 0){
                tfFrom.errorMessage = ERR_THIS_FILED_IS_REQ
            }else if (tfTo.text!.isEmpty){
                tfTo.errorMessage = ERR_THIS_FILED_IS_REQ
            }else if (tfDate.text!.isEmpty){
                tfDate.errorMessage = ERR_THIS_FILED_IS_REQ
            }else{
                //Show the dialog
                clearError()
                //Send to list
                showError(message: "Sorry service not available!")
            }
        
        
    }
    
    func clearError(){
           tfFrom.errorMessage = ""
           tfTo.errorMessage = ""
           tfDate.errorMessage = ""
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
            return cityArray.count
            
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if (pickerView == fromPv){
                if(tfFrom.text?.count == 0){
                    tfFrom.text = cityArray[row].cityName
                    fromCityCode = cityArray[row].cityId
                    fromCityName = cityArray[row].cityName
                    tfFrom.errorMessage = ""
                }
            return cityArray[row].cityName
            }else{
                if(tfTo.text?.count == 0){
                        tfTo.text = cityArray[row].cityName
                        toCityCode = cityArray[row].cityId
                        toCityName = cityArray[row].cityName
                        tfTo.errorMessage = ""
                    }
                return cityArray[row].cityName
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           if (pickerView == fromPv){
            tfFrom.errorMessage = ""
            if(cityArray.count > 0){
            tfFrom.text = cityArray[row].cityName
                               fromCityCode = cityArray[row].cityId
                               fromCityName = cityArray[row].cityName
                               tfFrom.errorMessage = ""
            }
           }
           else{
            tfFrom.errorMessage = ""
            if(cityArray.count > 0){
            tfFrom.text = cityArray[row].cityName
                               fromCityCode = cityArray[row].cityId
                               fromCityName = cityArray[row].cityName
                               tfFrom.errorMessage = ""
            }
            }
            }
     
    
}
