//
//  OnWayListVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 12/03/21.
//  Copyright © 2021 Kashif Imam. All rights reserved.
//

import UIKit

class OnWayListVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var lblFromTo: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tblFlightList: UITableView!
    
    var fromCity = "From"
    var toCity = "To"
    var dateFlight = ""
    
    var flightArray = FlightListDetails.flightJourneyInstance[0].segments
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblFlightList.delegate = self
        tblFlightList.dataSource = self
//        tblFlightList.rowHeight = UITableViewAutomaticDimension
//        tblFlightList.estimatedRowHeight = 100
        
        lblFromTo.text = fromCity + " -> " + toCity
        lblDate.text = dateFlight
    }
    
    
    @IBAction func onClickDeparture(_ sender: Any) {
    
    }
    
    @IBAction func onClickDuration(_ sender: Any) {
    
    }
    
    @IBAction func onClickTime(_ sender: Any) {
    
    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
           dismiss(animated: false)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
           print("noOfSection")
           return 1
    }
       
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightArray!.count
    }
       
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "FlightListCell", for: indexPath) as! FlightListCell
        cell.lblFlightCode.text = flightArray![indexPath.row].bonds[0].legs[0].airlineName + " " + flightArray![indexPath.row].bonds[0].legs[0].flightNumber
        cell.lblFlightName.text = flightArray![indexPath.row].bonds[0].legs[0].flightName
        if(flightArray![indexPath.row].fares[0].paxFares[0].refundable){
            cell.lblFlightIsRefundable.text = "Refundable"
        }else{
            cell.lblFlightIsRefundable.text = "Non refundable"
        }
        cell.lblArriveTime.text = flightArray![indexPath.row].bonds[0].legs[flightArray![indexPath.row].bonds[0].legs.count - 1].arrivalTime
        cell.lblDepTime.text = flightArray![indexPath.row].bonds[0].legs[0].departureTime
        cell.lblFlightAmount.text = "₹ " +  String(flightArray![indexPath.row].fares[0].totalFareWithOutMarkUp)
        if(flightArray![indexPath.row].bonds[0].legs.count == 1){
            cell.lblStop.text = "Non-Stop"
        }else{
            cell.lblStop.text = String(flightArray![indexPath.row].bonds[0].legs.count) + " Stops"
        }
        cell.lblFrom.text = fromCity
        cell.lblTo.text = toCity
        cell.lblDuration.text = flightArray![indexPath.row].bonds[0].journeyTime

        
        return cell
    }
       
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
       {
           return 147
       }
       
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
    }
       
    
}



class FlightListCell: UITableViewCell{
    @IBOutlet weak var lblFlightCode: UILabel!
    @IBOutlet weak var lblFlightName: UILabel!
    @IBOutlet weak var lblFlightAmount: UILabel!
    @IBOutlet weak var lblFlightIsRefundable: UILabel!
    
    @IBOutlet weak var lblDepTime: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblStop: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    
    @IBOutlet weak var lblArriveTime: UILabel!
    
    @IBOutlet weak var ivFlight: UIImageView!
    
    @IBOutlet weak var avLoader: UIActivityIndicatorView!
}
