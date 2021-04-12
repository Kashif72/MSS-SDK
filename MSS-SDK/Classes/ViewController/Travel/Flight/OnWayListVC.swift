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
    var flightPassanger = ""
    
    var listReq: FlightListRequest? = nil
    var listResponse: FlightListResponse? = nil
    
    
    var numberOfAdult = 0
    var numberOfChild = 0
    var numberOfInfant = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblFlightList.delegate = self
        tblFlightList.dataSource = self
        lblFromTo.text = fromCity + " -> " + toCity
        lblDate.text = dateFlight
    }
    
    
    
    @IBAction func onClickDeparture(_ sender: Any) {
//        let df = DateFormatter()
//        df.dateFormat = "hh:mm"
//        df.locale = Locale(identifier: "en_US_POSIX")
//        df.timeZone = TimeZone(identifier: "UTC")!
//
//        flightArray = flightArray!.sorted {df.date(from: $0.bonds[0].legs[0].departureTime)! > df.date(from: $1.bonds[0].legs[0].departureTime)!}
//        tblFlightList.reloadData()
        
        
        flightArray = flightArray!.sorted {
            $0.bonds[0].legs[0].departureTime < $1.bonds[0].legs[0].departureTime
        }
        tblFlightList.reloadData()
    }
    
    @IBAction func onClickDuration(_ sender: Any) {
//        flightArray = flightArray!.sorted(by: { getMins(duration: $0.fares[0].journeyTime) < $1.fares[0].journeyTime })
//
//        flightArray = compactMap(TimePoint.init)
//        .sorted()
//        .map { $0.journeyTime }
        
       tblFlightList.reloadData()
    }
    
    @IBAction func onClickTime(_ sender: Any) {
    flightArray = flightArray!.sorted(by: { $0.fares[0].totalFareWithOutMarkUp < $1.fares[0].totalFareWithOutMarkUp })
    tblFlightList.reloadData()
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
        let podBundle = Bundle(for: OnWayListVC.self)
        let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
        let controller = storyboard.instantiateViewController(withIdentifier: "FlightDetailVC")as! FlightDetailVC
        controller.selectedPosition = indexPath.row
        controller.dateFlight = dateFlight
        controller.fromCity = fromCity
        controller.toCity = toCity
        controller.totalPayable = "₹ " +  String(flightArray![indexPath.row].fares[0].totalFareWithOutMarkUp)
        controller.numberPassanger = flightPassanger
        controller.listReq = listReq
        controller.listResponse = listResponse
        controller.numberOfInfant = self.numberOfInfant
        controller.numberOfAdult = self.numberOfAdult
        controller.numberOfChild = self.numberOfChild
        

        
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
                             
    }
    
    func getMins(duration: String) -> Int{
        
        return 0
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
}


enum TimePoint {

    case hours(Int)
    case days(Int)

    init?(sentence: String) {
        let tokens = sentence.split(separator: " ")
        guard
            tokens.count == 3,
            let firstToken = tokens.first,
            let value = Int(firstToken)
            else { return nil }

        let unitString = String(tokens[1])

        switch unitString {
        case "hours": self = .hours(value)
        case "days": self = .days(value)
        default: return nil
        }

    }

    var description: String {
        switch self {
        case .days(let value): return "\(value) days ago"
        case .hours(let value): return "\(value) hours ago"
        }
    }
}

extension TimePoint: Comparable {

    private var hours: Int {
        switch self {
        case .hours(let value): return value
        case .days(let value): return 24 * value
        }
    }

    static func < (lhs: TimePoint, rhs: TimePoint) -> Bool {
        return lhs.hours < rhs.hours
    }
}
