//
//  MainFile.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 02/10/20.
//  Copyright © 2020 Kashif Imam. /Users/FilesPrograms/Ios-Programs/MSS-SDK/MSS-SDK/MSS-SDK.podspecAll rights reserved.
//

import Foundation
import UIKit


public class InitSDK{

    public init() {
        
    }

    
    public func open(caller: UIViewController, merchant: Merchant) {
        print("OPEN CLICKED")
        Merchant.merchantData = merchant
        
        let podBundle = Bundle(for: DashboardVC.self)
        let bundleURL = podBundle.url(forResource: "MSS-SDK", withExtension: "bundle")

        let bundle = Bundle(url: bundleURL!)!
        
        let storyboard = UIStoryboard(name: "MSSMain", bundle: bundle)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        controller.modalPresentationStyle = .fullScreen
        caller.present(controller, animated: true, completion: nil)
        
    }
    
    
    public func close(){
        //Broad Cast for stop
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_APP_CLOSE), object: nil, userInfo: nil)
    }
   
    
    
}

