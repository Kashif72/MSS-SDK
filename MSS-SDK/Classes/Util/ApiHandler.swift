//
//  ApiHandler.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 07/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import Foundation


import Foundation

import Alamofire
import SwiftyJSON


private let instance = APIHandler()


class APIHandler: NSObject {
    
    let base64LoginString = String(format: "%@:%@", "servicemandu", "servicemandu@2020").data(using: String.Encoding.utf8)!.base64EncodedString()
    
    
    class var sharedInstance: APIHandler {
        return instance
    }

    
    
    
    //GET METHOD
    func getGiftCatList(success: @escaping (_ response: String?) -> Void, failure: @escaping (_ error: String?) -> Void){
        
        if Util.isNetworkAvailable() {
            
            let urlString = ""
            _ = JSONEncoder()
            let url = URL(string: urlString)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            
            AF.request(request).responseData(completionHandler: { (response) in
                
                print("Response", response)
                    if let status = response.response?.statusCode {
                        switch(status){
                        case 200:
                            let decoder = JSONDecoder()
                            let responseValue = try! decoder.decode(GiftCardCatRespnse.self, from: response.data!)
                            if(responseValue.code == SUCCESS){
                                GiftCardCatModel.giftCardCatListInstance =  responseValue.details
                                success(responseValue.message);
                            }else{
                                failure(responseValue.message)
                            }
                            
                            print("Regsiter Response", responseValue)
                            
                        default:
                              failure("Error! \(String(status))")
                        }
                    }
                
            })
        } else {
            failure(NETWORK_FAIL_MSG)
        }
    }
    
}
