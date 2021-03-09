//
//  BusListVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 19/11/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit

class BusListVC: UIViewController {

    
    var fromCityCode = ""
    var toCityCode = ""
    var fromCityName = ""
    var toCityName = ""
    var dateofJourney = ""
    
    
    @IBOutlet weak var lblFromTo: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}




class BusListCell: UITableViewCell{
    @IBOutlet weak var lblBusName: UILabel!
    @IBOutlet weak var lblBusType: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSeatLeft: UILabel!
 }
