//
//  FlightFinalBookingVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 23/04/21.
//  Copyright © 2021 Kashif Imam. All rights reserved.
//

import UIKit

class FlightFinalBookingVC:  UIViewController {

    
    var numberOfAdult = 0
    var numberOfChild = 0
    var numberOfInfant = 0
    
    var tfPosition = 0
    
    @IBOutlet weak var viewMain: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        registerNotifications()
        
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
                case 4:
                    tf.placeholder = "Adult Date of Birth"
                default:
                    break
                }
                
                tf.tag = tfPosition
                scrollViewContainer.addArrangedSubview(tf)
            }
            
           }
        
        addChildTF()
       
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
                    case 4:
                        tf.placeholder = "Child Date of Birth"
                    default:
                        break
                    }
            
               tf.tag = tfPosition
               scrollViewContainer.addArrangedSubview(tf)
            }
           }
        
        addInfantTF()
       
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
            case 4:
                tf.placeholder = "Infant Date of Birth"
            default:
                break
            }
            tf.tag = tfPosition
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
           scrollViewContainer.addArrangedSubview(tf)
        
        addButtonProceed()
    }
    
    func addButtonProceed(){
           tfPosition = tfPosition + 1
           let button = CustomButton()
           button.heightAnchor.constraint(equalToConstant: 44).isActive = true
           button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48).isActive = true
            button.setTitle("Book Flight", for: .normal)
           button.tag = tfPosition
            button.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
           scrollViewContainer.addArrangedSubview(button)
        
    }
    
    @objc func didButtonClick(_ sender: UIButton) {
        //Check field and proceed
        print("Button Click"," Check field and proceed")
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
    
    
}
