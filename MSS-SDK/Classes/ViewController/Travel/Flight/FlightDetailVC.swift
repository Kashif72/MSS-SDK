//
//  FlightDetailVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 17/03/21.
//  Copyright © 2021 Kashif Imam. All rights reserved.
//

import UIKit
import MBProgressHUD
import TTGSnackbar



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
    
    
    var numberOfAdult = 0
    var numberOfChild = 0
    var numberOfInfant = 0
    
    
    var totalPayable = ""
    
    
    var flightLegArray: Array<LegsModel>? = nil
    
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    
    var listReq: FlightListRequest? = nil
    var listResponse: FlightListResponse? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flightLegArray = FlightListDetails.flightJourneyInstance[0].segments[selectedPosition].bonds[0].legs
        
        tblFlightDetails.delegate = self
        tblFlightDetails.dataSource = self
        
        lblNoPassanger.text = numberPassanger
        lblAmount.text = totalPayable
        lblFromTo.text = fromCity + " -> " + toCity
        
        tblHeight.constant = CGFloat(147 * flightLegArray!.count)
        
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
        
        cell.lblFromCode.text = flightLegArray![indexPath.row].origin
        
        //name
        cell.lblFromTime.text = flightLegArray![indexPath.row].departureTime
        cell.lblFromDate.text = flightLegArray![indexPath.row].departureDate
        cell.lblFromBaggae.text = "Bag: "+flightLegArray![indexPath.row].baggageWeight + flightLegArray![indexPath.row].baggageUnit
        
        cell.lblToCode.text = flightLegArray![indexPath.row].destination
        
        //name
        for item in FlightCityModel.flightCityInstance{
            if(item.cityCode == flightLegArray![indexPath.row].origin){
                cell.lblFromName.text = item.cityName
            }
          
        }
        
        for item in FlightCityModel.flightCityInstance{
             if(item.cityCode == flightLegArray![indexPath.row].destination){
                cell.lblToName.text = item.cityName
            }
          
        }
    
        cell.lblToTime.text = flightLegArray![indexPath.row].arrivalTime
        cell.lblToDate.text = flightLegArray![indexPath.row].arrivalDate
        cell.lblToBaggae.text = " "
        
        
        
        return cell
    }
       
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
           return 147
    }
    
    
    
    @IBAction func onClickBook(_ sender: Any) {
        //Calculate price and send to form page
        calPrice()
    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
              dismiss(animated: false)
    }
    
    
    
    func calPrice (){
            self.showLoading(view: self.view, text: "Please wait")
            //Send to list
            var req = CheckFinalPriceReq()
            req.bonds = listResponse?.details.journeys[0].segments[selectedPosition].bonds
            req.fares = listResponse?.details.journeys[0].segments[selectedPosition].fares
            
            if(listResponse?.details.journeys[0].segments[selectedPosition].baggageFare == true){
                req.baggageFare = "true"
            }else{
                req.baggageFare = "false"
            }
            
            if(listResponse?.details.journeys[0].segments[selectedPosition].cache == true){
                req.cache = "true"
            }else{
                req.cache = "false"
            }
        
            if(listResponse?.details.journeys[0].segments[selectedPosition].holdBooking == true){
                req.holdBooking = "true"
            }else{
                req.holdBooking = "false"
            }
        
        if(listResponse?.details.journeys[0].segments[selectedPosition].international == true){
            req.international = "true"
        }else{
            req.international = "false"
        }
        
        if(listResponse?.details.journeys[0].segments[selectedPosition].roundTrip == true){
            req.roundTrip = "true"
        }else{
            req.roundTrip = "false"
        }
        
        if(listResponse?.details.journeys[0].segments[selectedPosition].special == true){
                   req.special = "true"
               }else{
                   req.special = "false"
               }
        
        if(listResponse?.details.journeys[0].segments[selectedPosition].specialId == true){
            req.specialId = "true"
        }else{
            req.specialId = "false"
        }
        
        req.engineID = listResponse?.details.journeys[0].segments[selectedPosition].engineID
        req.fareRule = listResponse?.details.journeys[0].segments[0].fareRule
        
        req.itineraryKey = listResponse?.details.journeys[0].segments[selectedPosition].itineraryKey
        
        req.journeyIndex = "0"
            
        if(listResponse?.details.journeys[0].segments[selectedPosition].nearByAirport == true){
                   req.nearByAirport = "true"
               }else{
                   req.nearByAirport = "false"
               }
        
        
        req.searchId = listResponse?.details.journeys[0].segments[selectedPosition].searchId
        
        req.origin = fromCity
        req.destination = toCity
        
        req.tripType = "OneWay"
        
        
        req.adults = numberOfAdult
        req.infants = numberOfInfant
        req.childs = numberOfChild
        req.traceId = listResponse?.details.traceId
        
        req.cabin = listResponse?.details.journeys[0].segments[selectedPosition].bonds[0].legs[0].cabin
        req.beginDate = dateFlight
        req.endDate = dateFlight
        req.traceId = "AYTM00011111111110002"
        
        
        let jsonData = try! JSONEncoder().encode(req)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print(jsonString)
        
        
        
        APIHandler.sharedInstance.getFlightPriceDetail(loginReq: req, success: { (sessionId, baseFare, totalTax, totalFare) in
                              //Success
            self.stopLoading(fromView: self.view)
                //show dialog here
            self.showConfirmDialog(message: "Base fare: \(String(describing: baseFare))\nTotal tax: \(String(describing: totalTax))\n Total fare: \(String(describing: totalFare))")
                              
            }, failure: { (message) in
                self.stopLoading(fromView: self.view)
                self.showError(message: message!)
            })
        
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

   
    func showConfirmDialog(message: String){
        let alert = UIAlertController(title: "Please confirm", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let confirmAction = UIAlertAction(title: "Continue", style: UIAlertAction.Style.default)
        {
            (UIAlertAction) -> Void in
            
            self.dismiss(animated: false)
            //CALL NEW PAGE
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("didPress cancel")
        }
        
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        
        present(alert, animated: true)
        {
            () -> Void in
        }
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
