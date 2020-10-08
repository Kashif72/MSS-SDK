//
//  MobileRechargeVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 06/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit

class MobileRechargeVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var tfMobile: CustomTF!
    @IBOutlet weak var tfServiceProvider: CustomTF!
    
    @IBOutlet weak var tfArea: CustomTF!
    @IBOutlet weak var tfAmount: CustomTF!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfMobile.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfServiceProvider.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfArea.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfAmount.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    
    @IBAction func onBack(_ sender: Any) {
           dismiss(animated: false)
       
    }
    
    @IBAction func onClickPlans(_ sender: Any) {
        
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
    
    
    @IBAction func onClickPay(_ sender: Any) {
    }
    
    
    
    
}
