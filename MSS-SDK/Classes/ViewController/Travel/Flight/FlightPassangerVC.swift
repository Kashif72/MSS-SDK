//
//  FlightPassangerVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 30/03/21.
//  Copyright © 2021 Kashif Imam. All rights reserved.
//

import UIKit
import TTGSnackbar


class FlightPassangerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pvAdult: UIPickerView!
    @IBOutlet weak var pvChild: UIPickerView!
    @IBOutlet weak var pvInfant: UIPickerView!
    
    var pickerData:[Int] = [0,1,2,3,4,5,6,7,8,9]
    
    
    var numberOfAdult = 0
    var numberOfChild = 0
    var numberOfInfant = 0
    
    var passengerListner : PassangerSelecListner? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pvAdult.delegate = self
        self.pvAdult.dataSource = self
        
        self.pvChild.delegate = self
        self.pvChild.dataSource = self
        
        self.pvInfant.delegate = self
        self.pvInfant.dataSource = self
    }
    
    
    @IBAction func onClickDismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func onClickSelect(_ sender: Any) {
        if(numberOfAdult == 0 && numberOfChild == 0 && numberOfInfant == 0){
            showError(message: "Please select passanger to continue")
        }else{
            passengerListner?.onPassSelected(adult: numberOfAdult, child: numberOfChild, infant: numberOfInfant)
                dismiss(animated: false)
        }
    
    }
    
    func showError(message: String){
           let snackbar = TTGSnackbar(message: message, duration: .short)
           snackbar.animationType = .slideFromTopBackToTop
           snackbar.backgroundColor = ColorConverter.hexStringToUIColor(hex: ColorCode.txtError)
           snackbar.show()
       }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == pvAdult){
            numberOfAdult = pickerData[row]
            return String(pickerData[row])
        }else if(pickerView == pvChild){
            numberOfChild = pickerData[row]
            return String(pickerData[row])
        }else{
            numberOfInfant = pickerData[row]
            return String(pickerData[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView == pvAdult){
            numberOfAdult = pickerData[row]
        }else if(pickerView == pvChild){
            numberOfChild = pickerData[row]
            
        }else{
            numberOfInfant = pickerData[row]
        }
    }
    
    
}
