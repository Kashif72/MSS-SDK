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
    
      
    var parentViewController:UIViewController!
    
    init() {
        
    }
    
    
    
    func open() {
        let storyboard = UIStoryboard(name: "Features", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        controller.modalPresentationStyle = .fullScreen
        parentViewController.present(controller, animated: false)
        
        
    }
}

