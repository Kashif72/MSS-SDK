//
//  BusModel.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 16/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import Foundation

struct BusCityModel : Codable{
    public var cityId : String!
    public var cityName : String!
    static var busCityInstance = Array<BusCityModel>()
}

struct BusCityResponse : Codable{
    public var code : String!
    public var message : String!
    public var details : Array<BusCityModel>!
}






