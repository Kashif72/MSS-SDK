//
//  MainFile.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 02/10/20.
//  Copyright © 2020 Kashif Imam. /Users/FilesPrograms/Ios-Programs/MSS-SDK/MSS-SDK/MSS-SDK.podspecAll rights reserved.
//

import Foundation
import UIKit


public class MainFile{
    
      
//    var parentViewController: UIViewController!
    
    public init() {
        
    }
    
    
    
    public func open(caller: UIViewController) {
        print("OPEN CLICKED")
        
        let podBundle = Bundle(forClass: DashboardVC.self)
        let bundleURL = podBundle.URLForResource("MSS-SDK", withExtension: "bundle")

        let storyboard = UIStoryboard(name: "MSSMain", bundle: podBundle)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        controller.modalPresentationStyle = .fullScreen
        caller.presentViewController(vc, animated: true, completion: nil)
        
    }
}

