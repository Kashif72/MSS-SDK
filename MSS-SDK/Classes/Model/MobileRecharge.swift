//
//  MobileRecharge.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 07/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import Foundation


struct PlanModel : Codable{
    public var planName : String!
    public var amount : String!
    public var description : String!
    public var validity : String!
    public var operatorCode : String!
    public var smsDaakCode : String!

    
    static var fTUniqueI = Array<PlanModel>()
    static var specialUniqueI = Array<PlanModel>()
    static var TwoGUniqueI = Array<PlanModel>()
    static var ThreeGUniqueI = Array<PlanModel>()
    static var TopUpGUniqueI = Array<PlanModel>()
}


struct PlanRequest : Codable{
    public var circleCode : String!
    public var serviceProvider : String!

}


struct PlanResponse : Codable{
    public var code : String!
    public var message : String!
    public var plans: Array<PlanModel>!
}



struct AutoNumberRequest : Codable{
    public var mobileNumber : String!
    
}

struct AutoNumberModel : Codable{
    public var serviceName : String!
    public var serviceCode : String!
    public var circleName : String!
    public var circleCode : String!
    public var code : String!
}

struct AutoNumberResponse: Codable {
    public var code : String!
    public var message : String!
    public var details : AutoNumberModel!
}







struct MCircleModel:Codable {
    public var id : Int64!
    public var name : String!
    public var code : String!
    
    static var preCircleModel = Array<MCircleModel>()
}


struct MOperatorModel:Codable {
    public var code : String!
    public var name : String!
    public var serviceLogo : String!
    
    static var preOptModel = Array<MOperatorModel>()
    
}


struct MOptCircResponse: Codable {
    public var code : String!
    public var message : String!
    
    public var details: Array<MOperatorModel>!
    public var circles: Array<MCircleModel>!
    
}

struct MOptCircRequest: Codable {
    public var topUpType : String!
    
    
}
