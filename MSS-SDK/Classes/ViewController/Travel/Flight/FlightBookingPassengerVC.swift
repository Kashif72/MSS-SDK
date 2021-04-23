//
//  FlightBookingPassengerVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 29/03/21.
//  Copyright © 2021 Kashif Imam. All rights reserved.
//

import UIKit

class FlightBookingPassengerVC: UIViewController {

    var tfPosition = 0
    
    var numberOfAdult = 0
    var numberOfChild = 0
    var numberOfInfant = 0
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tfEmail: CustomTF!
    @IBOutlet weak var tfMobile: CustomTF!
   
    @IBOutlet weak var btnBook: CustomButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAdultTF()
    
    }
    
    
    func addAdultTF(){
        self.tfPosition = 84
    
        for _ in 0...numberOfAdult {
            
            tfPosition = tfPosition + 60
            let tf = CustomTF()
            
            tf.frame = CGRect(x: 24, y: CGFloat(tfPosition), width: UIScreen.main.bounds.width - 48, height: 44)
            tf.placeholder = "Add Adult Details"
            tf.tag = tfPosition
            
            self.mainView.addSubview(tf)
        }
        
        addChildTF()
    }

    
    func addChildTF(){
           
        for _ in 0...numberOfChild {
               
               tfPosition = tfPosition + 60
               let tf = CustomTF()
               
               tf.frame = CGRect(x: 24, y: CGFloat(tfPosition), width: UIScreen.main.bounds.width - 48, height: 44)
               tf.placeholder = "Add Child Details"
               tf.tag = tfPosition
               
               self.mainView.addSubview(tf)
           }
        
        addInfantTF()
       }
    
    
    
    func addInfantTF(){
             
        for _ in 0...numberOfInfant {
                 
                 tfPosition = tfPosition + 60
                 let tf = CustomTF()
                 
                 tf.frame = CGRect(x: 24, y: CGFloat(tfPosition), width: UIScreen.main.bounds.width - 48, height: 44)
                 tf.placeholder = "Add Infant Details"
                 tf.tag = tfPosition
                 
                 self.mainView.addSubview(tf)
             }
         }
    
    
    

}
