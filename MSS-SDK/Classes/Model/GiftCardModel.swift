//
//  GiftCardModel.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 06/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import Foundation


struct GiftCardModel : Codable{
    public var product_id : String!
    public var product_name : String!
    public var product_description : String!
    public var product_terms_conditions : String!
    public var product_expiry_and_validity : String!
    public var product_how_to_use : String!
    public var product_image : String!
    public var categories : String!
    public var currency_code : String!
    public var currency_name : String!
    public var min_price : String!
    public var max_price : String!
    


    
    static var giftCardListInstance = Array<GiftCardModel>()
}


struct GiftCardCatModel : Codable{
    public var id : Int32!
    public var serviceName : String!
    public var code : String!
    public var description : String!
    public var serviceLogo : String!
    static var giftCardCatListInstance = Array<GiftCardCatModel>()
}



struct GiftCardCatRespnse : Codable{
    public var code : String!
    public var message : String!
    public var details : Array<GiftCardCatModel>!
    
}









