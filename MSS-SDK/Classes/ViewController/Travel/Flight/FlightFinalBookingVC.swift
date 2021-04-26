//
//  FlightFinalBookingVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 23/04/21.
//  Copyright © 2021 Kashif Imam. All rights reserved.
//

import UIKit

class FlightFinalBookingVC:  UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var numberOfAdult = 0
    var numberOfChild = 0
    var numberOfInfant = 0
    
    var totalParam = 0
    
    var tfPosition = 0
    
    var currentDateTag = 0
    var currentGenderTag = 0
    
    @IBOutlet weak var viewMain: UIView!
    
    let datePicker = UIDatePicker()
    
    
    let genderPv = UIPickerView()
    
    var genderArray = ["Male","Female","Other"]
    
    
    var listReq: FlightListRequest? = nil
    var listResponse: FlightListResponse? = nil
    var selectedPosition = 0
    var bookingAmount = ""
    
    
    var beginDate = ""
    var destination = ""
    var origin = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        totalParam = ((numberOfInfant + numberOfChild + numberOfAdult) * 4) + 2
        
        
        viewMain.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        
        addAdultTF()
        
        scrollView.leadingAnchor.constraint(equalTo: viewMain.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: viewMain.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: viewMain.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: viewMain.bottomAnchor).isActive = true

    
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        self.genderPv.delegate = self
           
        
        registerNotifications()
        
    }
    
    
    @objc func dateField(sender: CustomTF) {
        currentDateTag = sender.tag
        showDatePicker(sender: sender)
    }
    
    @objc func genderField(sender: CustomTF) {
        currentGenderTag = sender.tag
        (view.viewWithTag(currentGenderTag) as? CustomTF)?.inputView = genderPv
        
    }
    
    
    
    func showDatePicker(sender: CustomTF){
          //Formate Date
          datePicker.datePickerMode = .date
          
          let currentDate = Date()
          var dateComponents = DateComponents()
          let calendar = Calendar.init(identifier: .gregorian)
          
            dateComponents.year = -90
        
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
          
          doneButton.action = #selector(doneDate(sender:))
          
          toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
          sender.inputAccessoryView = toolbar
          sender.inputView = datePicker
        
      }
      
      
      @objc func doneDate(sender: CustomTF){
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd"
          
        
            (view.viewWithTag(currentDateTag) as? CustomTF)?.text = formatter.string(from: datePicker.date)
          (view.viewWithTag(currentDateTag) as? CustomTF)?.errorMessage = ""
          
            self.view.endEditing(true)

      }
      
      @objc func cancelDatePicker(){
          self.view.endEditing(true)
      }
    
    
    
    
    @IBAction func onClickDismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()

        view.axis = .vertical
        view.spacing = 10

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //Dynamic Views
    
    
     func addAdultTF(){
                
           for _ in 1...numberOfAdult {
            
            for index in 1...4{
                tfPosition = tfPosition + 1
                let tf = CustomTF()
                tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
                tf.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48).isActive = true
                
                switch index {
                case 1:
                    tf.placeholder = "Adult First Name"
                case 2:
                    tf.placeholder = "Adult Last Name"
                case 3:
                    tf.placeholder = "Adult Gender"
//                    tf.inputView = self.genderPv
                    tf.addTarget(self, action: #selector(genderField(sender:)), for: .editingDidBegin)
                    
                case 4:
                    tf.placeholder = "Adult Date of Birth"
                    tf.addTarget(self, action: #selector(dateField(sender:)), for: .editingDidBegin)
                default:
                    break
                }
                
                tf.tag = tfPosition
                tf.addDoneButtonOnKeyboard()
                scrollViewContainer.addArrangedSubview(tf)
            }
            
           }
        
        if(numberOfChild != 0){
            addChildTF()
        }else if (numberOfInfant != 0){
            addInfantTF()
        }else{
            addMobileTF()
        }
        
       
       }
    
    
    func addChildTF(){
                
           for _ in 1...numberOfChild {
            
            for index in 1...4{
            tfPosition = tfPosition + 1
               let tf = CustomTF()
               tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
               tf.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48).isActive = true
                switch index {
                    case 1:
                        tf.placeholder = "Child First Name"
                    case 2:
                        tf.placeholder = "Child Last Name"
                    case 3:
                        tf.placeholder = "Child Gender"
//                        tf.inputView = self.genderPv
                    tf.addTarget(self, action: #selector(genderField(sender:)), for: .editingDidBegin)
                    case 4:
                        tf.placeholder = "Child Date of Birth"
                    tf.addTarget(self, action: #selector(dateField(sender:)), for: .editingDidBegin)
                    default:
                        break
                    }
            
               tf.tag = tfPosition
                tf.addDoneButtonOnKeyboard()
               scrollViewContainer.addArrangedSubview(tf)
            }
           }
            if (numberOfInfant != 0){
                addInfantTF()
            }else{
                 addMobileTF()
            }
       }
    
    func addInfantTF(){
             
        for _ in 1...numberOfInfant {
            
            for index in 1...4{
                
                
            tfPosition = tfPosition + 1
            let tf = CustomTF()
            tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
            tf.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48).isActive = true
            switch index {
            case 1:
                tf.placeholder = "Infant First Name"
            case 2:
                tf.placeholder = "Infant Last Name"
            case 3:
                tf.placeholder = "Infant Gender"
//                tf.inputView = self.genderPv
                tf.addTarget(self, action: #selector(genderField(sender:)), for: .editingDidBegin)
            case 4:
                tf.placeholder = "Infant Date of Birth"
                tf.addTarget(self, action: #selector(dateField(sender:)), for: .editingDidBegin)
            default:
                break
            }
            tf.tag = tfPosition
                tf.addDoneButtonOnKeyboard()
            scrollViewContainer.addArrangedSubview(tf)
            }
        }
        
        addMobileTF()
    
    }
    
    
    func addMobileTF(){
        tfPosition = tfPosition + 1
        let tf = CustomTF()
        tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        tf.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48).isActive = true
        tf.placeholder = "Mobile Number"
        tf.tag = tfPosition
        tf.addDoneButtonOnKeyboard()
        tf.keyboardType = UIKeyboardType.numberPad
        tf.maxLength = 10
        scrollViewContainer.addArrangedSubview(tf)
        
        addEmailTF()
    }

    
    func addEmailTF(){
           tfPosition = tfPosition + 1
           let tf = CustomTF()
           tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
           tf.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48).isActive = true
           tf.placeholder = "Email id"
           tf.tag = tfPosition
            tf.addDoneButtonOnKeyboard()
            tf.keyboardType = UIKeyboardType.emailAddress
           scrollViewContainer.addArrangedSubview(tf)
        
        addButtonProceed()
    }
    
    func addButtonProceed(){
           tfPosition = tfPosition + 1
            let button = UIButton(type: UIButton.ButtonType.system) as UIButton
            
            let xPostion:CGFloat = 50
            let yPostion:CGFloat = 100
            let buttonWidth:CGFloat = 150
            let buttonHeight:CGFloat = 45
            
            button.frame = CGRect(x:xPostion, y:yPostion, width:buttonWidth, height:buttonHeight)
            
            
            button.setTitle("Book flight", for: UIControl.State.normal)
            button.tintColor = UIColor.black
            
            button.layer.cornerRadius = 1.0
            button.backgroundColor = ColorConverter.hexStringToUIColor(hex: ColorCode.btnOne)
        
            button.setTitleColor(ColorConverter.hexStringToUIColor(hex: ColorCode.textWhiteColor), for: .normal)
        
            button.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
            scrollViewContainer.addArrangedSubview(button)
        
    }
    
    
    
    
    func checkDynamicTF(){
        
        for index in 1...totalParam {
            
            if let foundView = view.viewWithTag(index) as? CustomTF  {
                print("TAGS-Found", foundView.tag)
                print("TAGS-Found-Value", foundView.text!)
                
                if(foundView.text!.count == 0){
                    foundView.errorMessage = "This field is required"
                }else{
                    
                    if(index == totalParam){
                        clearError()
                        //Prepare request param here
                        var req = FlightPayRequest()
                        req.bookSegments = listResponse?.details.journeys[0].segments[selectedPosition]
                        req.emailAddress = (view.viewWithTag(((numberOfInfant + numberOfChild + numberOfAdult) * 4) + 1) as? CustomTF)?.text
                        req.mobileNumber = (view.viewWithTag(((numberOfInfant + numberOfChild + numberOfAdult) * 4) + 2) as? CustomTF)?.text
                        req.visatype = ""
                        req.traceId = "AYTM00011111111110002"
                        req.androidBooking = true
                        req.domestic = !(listResponse?.details.journeys[0].segments[selectedPosition].international)!
                        req.ticketDetails = ""
                        
                        req.engineID = listResponse?.details.journeys[0].segments[selectedPosition].engineID
                        
                        req.engineIDList = getEngineIdList()
                        
                        req.bookingAmount = bookingAmount
                        
                        req.bookingCurrencyCode = "INR"
                        req.flightSearchDetails = getFlightSearchDetail()
                        req.travellerDetails = getTravellerDetail()
                        
                        
                        
                        
                        
                    }
                    
                }
            }
        }
    }
    
    
    func getEngineIdList() -> Array<String>{
        var englineArray = [String]()
        englineArray.append((listResponse?.details.journeys[0].segments[selectedPosition].engineID)!)
        return englineArray
    }
    
    
    func getFlightSearchDetail() -> Array<FlightBookingDetailsModel>{
        var details = Array<FlightBookingDetailsModel>()
        details.append(FlightBookingDetailsModel(beginDate: beginDate, destination : destination, origin: origin))
        return details
    }
    
    
    
    //Adding values to textfield
    func getTravellerDetail() -> Array<TravellerDetailsModel>{
        
        var details = Array<TravellerDetailsModel>()
        var fName = ""
        var lName = ""
        var title = ""
        var gender = ""
        var type = ""
        var dob = ""
        let passNo = ""
        let passExpDate = ""
        
        var mainIndex = 1
        
             for _ in 1...numberOfAdult {
                for index in 1...4{
                    switch index {
                    case 1:
                        fName = (view.viewWithTag(mainIndex) as? CustomTF)!.text!
                        mainIndex = mainIndex + 1
                    case 2:
                        lName = (view.viewWithTag(mainIndex) as? CustomTF)!.text!
                        mainIndex = mainIndex + 1
                    case 3:
                        gender = (view.viewWithTag(mainIndex) as? CustomTF)!.text!
                        
                        if((view.viewWithTag(mainIndex) as? CustomTF)!.text! == "Male"){
                            title = "Mr"
                        }else{
                            title = "Ms"
                        }
                        
                        mainIndex = mainIndex + 1
                    case 4:
                        dob = (view.viewWithTag(mainIndex) as? CustomTF)!.text!
                        mainIndex = mainIndex + 1
                    default:
                        break
                    }
                    
                    
                }
            type = "adult"
            details.append(TravellerDetailsModel(fName: fName,lName: lName, title: title, gender: gender, type:type, dob:dob, passNo:passNo, passExpDate:passExpDate))
                
            }
                
            if(numberOfChild != 0){
                    for _ in 1...numberOfChild {
                        for index in 1...4{
                            switch index {
                            case 1:
                                fName = (view.viewWithTag(mainIndex) as? CustomTF)!.text!
                                mainIndex = mainIndex + 1
                            case 2:
                                lName = (view.viewWithTag(mainIndex) as? CustomTF)!.text!
                                mainIndex = mainIndex + 1
                            case 3:
                                gender = (view.viewWithTag(mainIndex) as? CustomTF)!.text!
                                
                                if((view.viewWithTag(mainIndex) as? CustomTF)!.text! == "Male"){
                                    title = "Mr"
                                }else{
                                    title = "Ms"
                                }
                                
                                mainIndex = mainIndex + 1
                            case 4:
                                dob = (view.viewWithTag(mainIndex) as? CustomTF)!.text!
                                mainIndex = mainIndex + 1
                            default:
                                break
                            }
                            
                            
                        }
                    type = "Child"
                    details.append(TravellerDetailsModel(fName: fName,lName: lName, title: title, gender: gender, type:type, dob:dob, passNo:passNo, passExpDate:passExpDate))
                        
                    }
            }
            
            if (numberOfInfant != 0){
                  for _ in 1...numberOfInfant {
                      for index in 1...4{
                          switch index {
                          case 1:
                              fName = (view.viewWithTag(mainIndex) as? CustomTF)!.text!
                              mainIndex = mainIndex + 1
                          case 2:
                              lName = (view.viewWithTag(mainIndex) as? CustomTF)!.text!
                              mainIndex = mainIndex + 1
                          case 3:
                              gender = (view.viewWithTag(mainIndex) as? CustomTF)!.text!
                              
                              if((view.viewWithTag(mainIndex) as? CustomTF)!.text! == "Male"){
                                  title = "Mr"
                              }else{
                                  title = "Ms"
                              }
                              
                              mainIndex = mainIndex + 1
                          case 4:
                              dob = (view.viewWithTag(mainIndex) as? CustomTF)!.text!
                              mainIndex = mainIndex + 1
                          default:
                              break
                          }
                          
                          
                      }
                  type = "Infant"
                  details.append(TravellerDetailsModel(fName: fName,lName: lName, title: title, gender: gender, type:type, dob:dob, passNo:passNo, passExpDate:passExpDate))
                      
                  }
            }
        
        return details
    }
    
//    public var fName : String!
//    public var lName : String!
//    public var title : String!
//
//    public var gender : String!
//    public var type : String!
//    public var dob : String!
//
//    public var passNo : String!
//    public var passExpDate : String!
    
    
    func clearError(){
        for index in 1...totalParam {
            if let foundView = view.viewWithTag(index) as? CustomTF  {
                   foundView.errorMessage = ""
                
            }
        }
    }
    
    
    @objc func didButtonClick(_ sender: UIButton) {
        //Check field and proceed
        clearError()
        checkDynamicTF()
    }
   
    
        private func registerNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
        
        private func unregisterNotifications() {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
        
        
        @objc func keyboardWillShow(notification: NSNotification){
            guard let keyboardFrame = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
            scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
        }
        
        @objc func keyboardWillHide(notification: NSNotification){
            scrollView.contentInset.bottom = 0
        }

    
    
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         unregisterNotifications()
     }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return genderArray.count
          
       }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           
               if((view.viewWithTag(currentGenderTag) as? CustomTF)?.text?.count == 0){
                
                (view.viewWithTag(currentGenderTag) as? CustomTF)?.text = genderArray[row]
                (view.viewWithTag(currentGenderTag) as? CustomTF)?.errorMessage = ""
               }
               return genderArray[row]
           
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          
               (view.viewWithTag(currentGenderTag) as? CustomTF)?.errorMessage = ""
               if(genderArray.count > 0){
                   (view.viewWithTag(currentGenderTag) as? CustomTF)?.text = genderArray[row]
                   (view.viewWithTag(currentGenderTag) as? CustomTF)?.errorMessage = ""
               }
           
           
       }
    
}
