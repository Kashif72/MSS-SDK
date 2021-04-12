//
//  FlightSearchVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 12/03/21.
//  Copyright © 2021 Kashif Imam. All rights reserved.
//

import UIKit
import MBProgressHUD
import TTGSnackbar


class FlightSearchVC: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, PassangerSelecListner, CitySelecListner {
    
    @IBOutlet weak var tfFrom: CustomTF!
    @IBOutlet weak var tfTo: CustomTF!
    @IBOutlet weak var tfDate: CustomTF!
    @IBOutlet weak var tfTraveller: CustomTF!
    @IBOutlet weak var tfClass: CustomTF!
    
    var cityArray = FlightCityModel.flightCityInstance
    
    var fromCityCode = ""
    var toCityCode = ""
    var fromCityName = ""
    var toCityName = ""
    var dateofJourney = ""
    
    
    let classPv = UIPickerView()
    
    
    
    var classArray = ["Economy","Business","Premium Economy"]
    
    let datePicker = UIDatePicker()
    
    
    var numberOfAdult = 0
    var numberOfChild = 0
    var numberOfInfant = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfFrom.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfTo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfDate.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfTraveller.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfClass.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.tfTraveller.inputView = UIView()
        self.tfTraveller.inputAccessoryView = UIView()
        
        
        self.classPv.delegate = self
        
        
        self.tfClass.inputView = self.classPv
     
        
        self.tfTraveller.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
    }
    
    
    @objc func myTargetFunction(textField: UITextField) {
        let podBundle = Bundle(for: FlightSearchVC.self)
        let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
        let controller = storyboard.instantiateViewController(withIdentifier: "FlightPassangerVC") as! FlightPassangerVC
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        controller.passengerListner = self
        
        self.present(controller, animated: true, completion: nil)
    }
    

    
    
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: false)
    }
    
    
    
    @IBAction func onDateofTravel(_ sender: Any) {
        showDatePicker()
    }
    
    
    @IBAction func onTravelBegin(_ sender: Any) {
        let podBundle = Bundle(for: FlightSearchVC.self)
        let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
        let controller = storyboard.instantiateViewController(withIdentifier: "FlightPassangerVC") as! FlightPassangerVC
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        controller.passengerListner = self
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        let currentDate = Date()
        let dateComponents = DateComponents()
        let calendar = Calendar.init(identifier: .gregorian)
        
        let minDate = calendar.date(byAdding: dateComponents, to: currentDate)
        datePicker.minimumDate = minDate
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem()
        doneButton.title = "Done"
        doneButton.style = .plain
        doneButton.target = self
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        doneButton.action = #selector(doneDate)
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        tfDate.inputAccessoryView = toolbar
        tfDate.inputView = datePicker
        
    }
    
    
    @objc func doneDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        tfDate.text = formatter.string(from: datePicker.date)
        dateofJourney = formatter.string(from: datePicker.date)
        tfDate.errorMessage = ""
        self.view.endEditing(true)
        
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func onClickSearch(_ sender: Any) {
        checkField()
    }
    
    
    @IBAction func onClickCancel(_ sender: Any) {
        
        
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
            case tfTraveller:
                if(text.count == 0){
                    tfTraveller.errorMessage = ERR_THIS_FILED_IS_REQ
                }
                else {
                    tfTraveller.errorMessage = ""
                }
                
            case tfClass:
                if(text.count == 0){
                    tfClass.errorMessage = ERR_THIS_FILED_IS_REQ
                }
                else {
                    tfClass.errorMessage = ""
                }
                
                
            default:
                break
            }
        }
    }
    
    
    @IBAction func onTouchCity(_ sender: CustomTF) {
        
        var type = 0
        if(sender == tfFrom){
            type = 0
        }else{
            type = 1
        }
        
        
        if(cityArray.count != 0){
         
            let podBundle = Bundle(for: FlightSearchVC.self)
            let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
            let bundle = Bundle(url: bundleURL!)!
            let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
            let controller = storyboard.instantiateViewController(withIdentifier: "CityListVC") as! CityListVC
            controller.selectListner = self
                           controller.selectType = type
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
            
        }
        else{
            self.showLoading(view: self.view, text: "Please wait")
            
         
            
            APIHandler.sharedInstance.getFlightCity(success: { (sessionId) in
                //Success
                self.stopLoading(fromView: self.view)
                self.cityArray = FlightCityModel.flightCityInstance
                //Send to City List
                
                let podBundle = Bundle(for: FlightSearchVC.self)
                let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
                let bundle = Bundle(url: bundleURL!)!
                let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
                let controller = storyboard.instantiateViewController(withIdentifier: "CityListVC") as! CityListVC
                controller.selectListner = self
                controller.selectType = type
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true, completion: nil)
                
            }, failure: { (message) in
                self.stopLoading(fromView: self.view)
                self.showError(message: message!)
            })
        }
        
    }
    
    
    func checkField (){
        if(tfFrom.text!.count == 0){
            tfFrom.errorMessage = ERR_THIS_FILED_IS_REQ
        }else if (tfTo.text!.isEmpty){
            tfTo.errorMessage = ERR_THIS_FILED_IS_REQ
        }else if (tfDate.text!.isEmpty){
            tfDate.errorMessage = ERR_THIS_FILED_IS_REQ
        }else if (tfTraveller.text!.isEmpty){
            tfTraveller.errorMessage = ERR_THIS_FILED_IS_REQ
        }else if (tfClass.text!.isEmpty){
            tfClass.errorMessage = ERR_THIS_FILED_IS_REQ
        }
        else{
            //Show the dialog
            clearError()
            self.showLoading(view: self.view, text: "Please wait")
            
            //Send to list
            var req = FlightListRequest()
            req.origin = fromCityCode
            req.destination = toCityCode
            req.tripType = "OneWay"
            req.cabin = tfClass.text!
            req.adults = numberOfAdult
            req.childs = numberOfChild
            req.infants = numberOfInfant
            req.traceId = "AYTM00011111111110002"
            req.beginDate = tfDate.text!
         
            APIHandler.sharedInstance.getFlightJourneyList(loginReq: req, success: { (sessionId, responseValue) in
                          //Success
                self.stopLoading(fromView: self.view)
                if(FlightListDetails.flightJourneyInstance[0].segments.count > 0){
                    let podBundle = Bundle(for: FlightSearchVC.self)
                    let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
                    let bundle = Bundle(url: bundleURL!)!
                    let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
                    let controller = storyboard.instantiateViewController(withIdentifier: "OnWayListVC") as! OnWayListVC
                    controller.fromCity = self.fromCityCode
                    controller.toCity = self.toCityCode
                    controller.dateFlight = self.tfDate.text!
                    controller.flightPassanger = self.tfTraveller.text!
                    controller.listReq = req
                    controller.listResponse = responseValue
                    controller.numberOfInfant = self.numberOfInfant
                    controller.numberOfAdult = self.numberOfAdult
                    controller.numberOfChild = self.numberOfChild
                    
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true, completion: nil)
                    
                    
                }else{
                    self.stopLoading(fromView: self.view)
                    self.showError(message: "Flight not found!")
                }
                          
            }, failure: { (message) in
                    self.stopLoading(fromView: self.view)
                    self.showError(message: message!)
        })
    }
        
        
    }
    
    func clearError(){
        tfFrom.errorMessage = ""
        tfTo.errorMessage = ""
        tfDate.errorMessage = ""
        tfTraveller.errorMessage = ""
        tfClass.errorMessage = ""
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
                   return classArray.count
       
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
            if(tfClass.text?.count == 0){
                tfClass.text = classArray[row]
                tfClass.errorMessage = ""
            }
            return classArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
            tfClass.errorMessage = ""
            if(classArray.count > 0){
                tfClass.text = classArray[row]
                tfClass.errorMessage = ""
            }
        
        
    }
    
    func onPassSelected(adult: Int, child: Int, infant: Int) {
        numberOfAdult = adult
        numberOfChild = child
        numberOfInfant = infant
        
        print("numberOfAdult", numberOfAdult)
        print("numberOfChild", numberOfChild)
        print("numberOfInfant", numberOfInfant)
        
        
        
        if(adult != 0 && child == 0 && infant == 0){
            tfTraveller.text = String(adult) + "Adults, "
        }else if(adult != 0 && child != 0 && infant == 0){
            tfTraveller.text = String(adult) + "Adults, " + String(child) + "Children, "
        }else if(adult != 0 && child != 0 && infant != 0){
            tfTraveller.text = String(adult) + "Adults, " + String(child) + "Children, " + String(infant) + "Infants, "
        }
        else if(adult == 0 && child != 0 && infant == 0){
            tfTraveller.text = String(child) + "Children, "
        }else if(adult == 0 && child != 0 && infant != 0){
            tfTraveller.text = String(child) + "Children, " + String(infant) + "Infants, "
        }

        else if(adult == 0 && child == 0 && infant != 0){
            tfTraveller.text = String(infant) + "Infants, "
        }else if(adult != 0 && child == 0 && infant != 0){
            tfTraveller.text = String(adult) + "Adults, " + String(infant) + "Infants, "
        }
        
        
    }
    
    
    func onFromSelected(from: String) {
        tfFrom.text = from
        fromCityCode = from
    }
    
    func onToSelected(to: String) {
        tfTo.text = to
        toCityCode = to
    }
}


protocol PassangerSelecListner {
    func onPassSelected(adult: Int, child: Int, infant: Int)
}


protocol CitySelecListner {
    func onFromSelected(from: String)
    func onToSelected(to: String)
}
