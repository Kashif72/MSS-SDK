//
//  Merchant.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 08/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import Foundation


public class Merchant {
    public var merchantName : String!
    public var url : String!

    static var merchantData = Merchant()

    init (){
        
    }
    
    public init(merchantName: String, url: String) {
        self.merchantName = merchantName
        self.url = url
    }
    
}
