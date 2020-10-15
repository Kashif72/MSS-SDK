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
            
            let urlString = "\(Merchant.merchantData.url!)\(URL_GET_GIFT_CARDS_CAT)"
            _ = JSONEncoder()
            let url = URL(string: urlString)!
            print("URL", url)
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.get.rawValue
         
            
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
    
        
    //Services and Offers
    
    func getGiftCardList(loginReq: GiftCardListRequest, success: @escaping (_ response: String?) -> Void, failure: @escaping (_ error: String?) -> Void){
            
            if Util.isNetworkAvailable() {
                
                let urlString = "\(Merchant.merchantData.url!)\(URL_GET_GIFT_CARDS_LIST)"
                let encoder = JSONEncoder()
                let reqValue = try! encoder.encode(loginReq)
                let url = URL(string: urlString)!
                var request = URLRequest(url: url)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
      
                
                request.httpBody = reqValue
                
                print("Request",loginReq)
                
                AF.request(request).responseData(completionHandler: { (response) in
                    
                    print("Response", response)
                        if let status = response.response?.statusCode {
                            switch(status){
                            case 200:
                                let decoder = JSONDecoder()
                                let responseValue = try! decoder.decode(GiftCardListResponse.self, from: response.data!)
                                
                                if(responseValue.code == SUCCESS){
                                    GiftCardModel.giftCardListInstance = responseValue.details.vouchers
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
    
   
    
    //Mobile Recharge
    func getAutoFetchNumber(loginReq: AutoNumberRequest, success: @escaping (_ response: AutoNumberModel?) -> Void, failure: @escaping (_ error: String?) -> Void){
            
            if Util.isNetworkAvailable() {
                
                let urlString = "\(Merchant.merchantData.url!)\(URL_AUTO_OPT)"
                let encoder = JSONEncoder()
                let reqValue = try! encoder.encode(loginReq)
                let url = URL(string: urlString)!
                var request = URLRequest(url: url)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
           
                
                request.httpBody = reqValue
                
                print("Request",loginReq)
                
                AF.request(request).responseData(completionHandler: { (response) in
                    
                    print("Response", response)
                        if let status = response.response?.statusCode {
                            switch(status){
                            case 200:
                                let decoder = JSONDecoder()
                                let responseValue = try! decoder.decode(AutoNumberResponse.self, from: response.data!)
                                
                                if(responseValue.code == SUCCESS){
                                    success(responseValue.details);
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
    
    
    
    
    func getMobilePlans(loginReq: PlanRequest, success: @escaping (_ response: String?) -> Void, failure: @escaping (_ error: String?) -> Void){
        
        if Util.isNetworkAvailable() {
            print("\(Merchant.merchantData.url!)\(URL_GET_PLANS)")
            let urlString = "\(Merchant.merchantData.url!)\(URL_GET_PLANS)"
            let encoder = JSONEncoder()
            let reqValue = try! encoder.encode(loginReq)
            let url = URL(string: urlString)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
      
            
            request.httpBody = reqValue
            
            print("Request",loginReq)
            
            AF.request(request).responseData(completionHandler: { (response) in
                
                print("Response", response)
                    if let status = response.response?.statusCode {
                        switch(status){
                        case 200:
                            let decoder = JSONDecoder()
                            let responseValue = try! decoder.decode(PlanResponse.self, from: response.data!)
                            
                            if(responseValue.code == SUCCESS){
                                
                                var talkTimePlans = [PlanModel]()
                                var topUpPlans = [PlanModel]()
                                var threeGPlans = [PlanModel]()
                                var twoGPlans = [PlanModel]()
                                var specialPlans = [PlanModel]()
                                
                                for items in responseValue.plans{
                                    if(items.planName == "Full Talktime"){
                                        talkTimePlans.append(items)
                                    }else if(items.planName == "Special Recharge"){
                                        specialPlans.append(items)
                                    }else if(items.planName == "2G Data"){
                                        twoGPlans.append(items)
                                    }else if(items.planName == "3G Data"){
                                        threeGPlans.append(items)
                                    }else if(items.planName == "Top up"){
                                        topUpPlans.append(items)
                                    }
                            }
                                
                                PlanModel.fTUniqueI = talkTimePlans
                                PlanModel.specialUniqueI = specialPlans
                                PlanModel.TwoGUniqueI = twoGPlans
                                PlanModel.ThreeGUniqueI = threeGPlans
                                PlanModel.TopUpGUniqueI = topUpPlans
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
    
    
    func getOptCircle(loginReq: MOptCircRequest, success: @escaping (_ response: String?) -> Void, failure: @escaping (_ error: String?) -> Void){
               
               if Util.isNetworkAvailable() {
                    print("\(Merchant.merchantData.url!)\(URL_GET_ALL_OP_CR)")
                   let urlString = "\(Merchant.merchantData.url!)\(URL_GET_ALL_OP_CR)"
                
                   let encoder = JSONEncoder()
                   let reqValue = try! encoder.encode(loginReq)
                   let url = URL(string: urlString)!
                   var request = URLRequest(url: url)
                   request.httpMethod = HTTPMethod.post.rawValue
                   request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            
                   
                   request.httpBody = reqValue
                   
                   print("Request",loginReq)
                   
                   AF.request(request).responseData(completionHandler: { (response) in
                       
                       print("Response", response)
                           if let status = response.response?.statusCode {
                               switch(status){
                               case 200:
                                   let decoder = JSONDecoder()
                                   let responseValue = try! decoder.decode(MOptCircResponse.self, from: response.data!)
                                   
                                   if(responseValue.code == SUCCESS){
                                    MOperatorModel.preOptModel = responseValue.details
                                    MCircleModel.preCircleModel = responseValue.circles
                                    
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
    
    func getDTHOpt(loginReq: MOptCircRequest, success: @escaping (_ response: String?) -> Void, failure: @escaping (_ error: String?) -> Void){
                  
                  if Util.isNetworkAvailable() {
                       print("\(Merchant.merchantData.url!)\(URL_GET_ALL_OP_CR)")
                      let urlString = "\(Merchant.merchantData.url!)\(URL_GET_ALL_OP_CR)"
                   
                      let encoder = JSONEncoder()
                      let reqValue = try! encoder.encode(loginReq)
                      let url = URL(string: urlString)!
                      var request = URLRequest(url: url)
                      request.httpMethod = HTTPMethod.post.rawValue
                      request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
               
                      
                      request.httpBody = reqValue
                      
                      print("Request",loginReq)
                      
                      AF.request(request).responseData(completionHandler: { (response) in
                          
                          print("Response", response)
                              if let status = response.response?.statusCode {
                                  switch(status){
                                  case 200:
                                      let decoder = JSONDecoder()
                                      let responseValue = try! decoder.decode(MOptCircResponse.self, from: response.data!)
                                      
                                      if(responseValue.code == SUCCESS){
                                       MOperatorModel.dthOptModel = responseValue.details
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
       
    
    
    //GET METHOD
    func getNewsList(success: @escaping (_ response: String?) -> Void, failure: @escaping (_ error: String?) -> Void){
        
        if Util.isNetworkAvailable() {
            
            let urlString = URL_GET_NEWS
            _ = JSONEncoder()
            let url = URL(string: urlString)!
            print("URL", url)
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.get.rawValue
         
            
            AF.request(request).responseData(completionHandler: { (response) in
                
                print("Response", response)
                    if let status = response.response?.statusCode {
                        switch(status){
                        case 200:
                            let decoder = JSONDecoder()
                            let responseValue = try! decoder.decode(NewsResponse.self, from: response.data!)
                            if(responseValue.status == "ok"){
                                NewsModel.newsListInstance = responseValue.articles
                                success("");
                            }else{
                                failure("Unable to fetch news")
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
