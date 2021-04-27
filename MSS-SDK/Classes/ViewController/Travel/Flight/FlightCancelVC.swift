//
//  FlightCancelVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 27/04/21.
//  Copyright © 2021 Kashif Imam. All rights reserved.
//

import UIKit

class FlightCancelVC: UIViewController {

    @IBOutlet weak var lblDetails: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDetails.text = "Dear Customer \n1.This page contains information on Flight Cancellation process. \n2.Flight can be cancelled only for confirmed bookings.\n3.Flight cancellation request once successfully submitted cannot be revoked.\n4.Airline may charge flight cancellation fee which may vary from airline to airline.\n5.For cancellation of flight, please visit website of respective airlines.\n6.For example, if ticket for Indigo flight has been booked, you are requested to visit https://www.goindigo.in\n7.Please keep your PNR ready during flight cancellation process.\n8.Flight cancellation refund amount will be credited to original account within 2-3 working days after successful cancellation of Flight."
        
    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: false)
    
    }
    
    
    
}
