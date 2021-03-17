//
//  FlightDetailVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 17/03/21.
//  Copyright © 2021 Kashif Imam. All rights reserved.
//

import UIKit

class FlightDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblNoPassanger: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblFromTo: UILabel!
    
    @IBOutlet weak var tblFlightDetails: UITableView!
    
    var selectedPosition = 0
    
    var fromCity = "From"
    var toCity = "To"
    var dateFlight = ""
    
    var numberPassanger = ""
    var totalPayable = ""
    
    var flightLegArray: Array<LegsModel>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flightLegArray = FlightListDetails.flightJourneyInstance[0].segments[selectedPosition].bonds[0].legs
        
        tblFlightDetails.delegate = self
        tblFlightDetails.dataSource = self
        
        
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
           print("noOfSection")
           return 1
    }
       
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightLegArray!.count
    }
       
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "FlightDetailsListCell", for: indexPath) as! FlightDetailsListCell
        
        cell.lblDuration.text = flightLegArray![indexPath.row].duration
        cell.lblFlightNumber.text = flightLegArray![indexPath.row].airlineName + " " + flightLegArray![indexPath.row].flightNumber
        
        cell.lblFromCode.text = flightLegArray![indexPath.row].departureTerminal
        cell.lblFromName.text = flightLegArray![indexPath.row].origin
        cell.lblFromTime.text = flightLegArray![indexPath.row].departureTime
        cell.lblFromDate.text = flightLegArray![indexPath.row].departureDate
        cell.lblFromBaggae.text = "Bag: "+flightLegArray![indexPath.row].baggageWeight + flightLegArray![indexPath.row].baggageUnit
        
        
        cell.lblToCode.text = flightLegArray![indexPath.row].arrivalTerminal
        cell.lblToName.text = flightLegArray![indexPath.row].destination
        cell.lblToTime.text = flightLegArray![indexPath.row].arrivalTime
        cell.lblToDate.text = flightLegArray![indexPath.row].arrivalDate
        cell.lblToBaggae.text = ""
        
        
        
        return cell
    }
       
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
           return 147
    }
    
    
    @IBAction func onClickBook(_ sender: Any) {
        dismiss(animated: false)
    }
    
}


class FlightDetailsListCell: UITableViewCell{
    @IBOutlet weak var lblFromCode: UILabel!
    @IBOutlet weak var lblFromName: UILabel!
    @IBOutlet weak var lblFromTime: UILabel!
    @IBOutlet weak var lblFromDate: UILabel!
    @IBOutlet weak var lblFromBaggae: UILabel!
    
    @IBOutlet weak var lblToCode: UILabel!
    @IBOutlet weak var lblToName: UILabel!
    @IBOutlet weak var lblToTime: UILabel!
    @IBOutlet weak var lblToDate: UILabel!
    @IBOutlet weak var lblToBaggae: UILabel!
    
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblFlightNumber: UILabel!
}
