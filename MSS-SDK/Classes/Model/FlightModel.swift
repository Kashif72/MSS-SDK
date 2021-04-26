//
//  FlightModel.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 14/03/21.
//  Copyright © 2021 Kashif Imam. All rights reserved.
//

import Foundation

//*********FOR CITY**********//
struct FlightCityModel : Codable{
    public var cityCode : String
    public var cityName : String
    public var airportName : String
    static var flightCityInstance = Array<FlightCityModel>()
}


struct FlightCityResponse : Codable{
    public var code : String
    public var message : String
    public var details : Array<FlightCityModel>
}


//*************FLIGHT LIST**************//
//Request
struct FlightListRequest : Codable{
    public var origin: String!
    public var destination: String!
    public var tripType: String!
    public var cabin: String!
    public var adults: Int!
    public var childs: Int!
    public var infants: Int!
    public var traceId: String!
    public var beginDate: String!
}



struct FlightListResponse : Codable {
    public var code: String
    public var message: String
    
    public var details : FlightListDetails!
}

struct FlightListDetails : Codable {
    public var journeys : Array<JourneysModel>!
    public var traceId : String!
    
    static var flightJourneyInstance = Array<JourneysModel>()
}

//This is inside details
struct JourneysModel : Codable {
    public var segments : Array<SegmentModel>!
    
}

//this is indside journey Array
public struct SegmentModel: Codable {
    
    public var bondType: String
    public var journeyTime : String!
    public var deeplink: String
    public var engineID: String
    public var fareRule: String
    public var itineraryKey: String
    public var journeyIndex: Int!
    public var nearByAirport: Bool
    
    public var remark: String
    public var searchId: String
    public var cache: Bool
    public var baggageFare: Bool
    public var holdBooking: Bool
    public var international: Bool
    public var roundTrip: Bool
    public var special: Bool
    public var specialId: Bool
    public var bonds : Array<BondModel>
    public var fares : Array<FareModel>
    
   
}

//This is inside Segment
struct FareModel : Codable{
    public var basicFare: Double
    public var exchangeRate: Double
    public var totalFareWithOutMarkUp: Double
    public var totalTaxWithOutMarkUp: Double
    public var paxFares : Array<PaxFareModel>
 }

//This is inside FareModel
struct PaxFareModel : Codable{
    public var baggageUnit: String
    public var baggageWeight: String
    public var baseTransactionAmount: Double
    public var basicFare: Double
    public var cancelPenalty: Double
    public var changePenalty: Double
    public var equivCurrencyCode: String
    public var bookFares : Array<BookFareModel>
    public var fareBasisCode: String
    public var fareInfoKey: String
    public var fareInfoValue: String
    public var markUP: Double
    public var paxType: String
    public var refundable: Bool
    public var totalFare: Double
    public var totalTax: Double
    public var transactionAmount: Double


}
//This is inside PaxFareModel
struct BookFareModel : Codable{
    public var amount: Double
    public var chargeCode: String
    public var chargeType: String
}

//This is inside SegmentModel
struct BondModel : Codable{
    public var boundType: String
    public var itineraryKey: String
    public var journeyTime: String
    public var legs : Array<LegsModel>
    public var baggageFare: Bool
    public var ssrFare: Bool
    
}


//This is inside BondModel
struct LegsModel: Codable {
    public var aircraftCode: String
    public var aircraftType: String
    public var airlineName: String
    public var amount: Int
    public var arrivalDate: String
    public var arrivalTerminal: String
    public var arrivalTime: String
    public var availableSeat: String
    public var baggageUnit: String
    public var baggageWeight: String
    public var boundTypes: String
    public var cabin: String
    public var capacity: String
    public var carrierCode: String
    public var currencyCode: String
    public var departureDate: String
    public var departureTerminal: String
    public var departureTime: String
    public var destination: String
    public var duration: String
    public var fareBasisCode: String
    public var fareClassOfService: String
    public var flightDesignator: String
    public var flightDetailRefKey: String
    public var flightNumber: String
    public var flightName: String
    public var group: String
    public var numberOfStops: String
    public var origin: String
    public var providerCode: String
    public var remarks: String
    public var sold: String
    public var status: String
    public var connecting: Bool
    
    
}



struct CheckFinalPriceReq: Codable {
        public var bonds : Array<BondModel>!
       public var fares : Array<FareModel>!
       public var baggageFare: String!
       
       public var cache: String!
       public var holdBooking: String!
       public var international: String!
       public var roundTrip: String!
       public var special: String!
       public var specialId: String!
       public var engineID: String!
       public var fareRule: String!
       public var itineraryKey: String!
       public var journeyIndex: String!
       public var nearByAirport: String!
       
       public var searchId: String!
        
        public var cabin: String!
       public var origin: String!
       public var destination: String!
       public var tripType: String!
       public var adults: Int!
       public var childs: Int!
       public var infants: Int!
       
       public var traceId: String!
       public var beginDate: String!
       public var endDate: String!
}

struct CheckFlightPriceRequest: Codable {
   

}




struct CheckFlightPriceResponse : Codable{
    public var code: String
    public var message: String
    
    public var details : FlightPriceDetails!

}



struct FlightPriceDetails : Codable {
    public var journeys : Array<FlightPriceJourneysModel>!
    
}

struct FlightPriceJourneysModel : Codable {
    public var segments : Array<FlightPriceSegmentModel>!
    
}


struct FlightPriceSegmentModel: Codable {
    public var fares : Array<FlightPriceFareModel>
}

struct FlightPriceFareModel : Codable{
    public var basicFare: Double
    public var totalFareWithOutMarkUp: Double
    public var totalTaxWithOutMarkUp: Double
   
}


public struct FlightPayRequest: Codable {
    public var bookSegments : SegmentModel!
    public var emailAddress : String!
    public var mobileNumber : String!
    public var visatype : String!
    public var traceId : String!
    public var androidBooking : Bool!
    public var domestic : Bool!
    public var engineID : String!
    public var engineIDList : [String]!
    public var bookingAmount : String!
    public var bookingCurrencyCode : String!
    public var ticketDetails : String!
    public var flightSearchDetails : Array<FlightBookingDetailsModel>!
    public var travellerDetails : Array<TravellerDetailsModel>!
    public var bankRefNo: String!
    
   
}


public struct FlightBookingDetailsModel: Codable{
    
    public var beginDate : String!
    public var destination : String!
    public var origin : String!
    
}

public struct TravellerDetailsModel: Codable{
    
    public var fName : String!
    public var lName : String!
    public var title : String!
    
    public var gender : String!
    public var type : String!
    public var dob : String!
    
    public var passNo : String!
    public var passExpDate : String!
    
    
}
