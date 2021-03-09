//
//  GiftTNCVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 20/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit

class GiftTNCVC: UIViewController {

    @IBOutlet weak var lblTNC: UILabel!
    
    var tnc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTNC.attributedText = tnc.htmlToAttributedString
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onBack(_:)), name: Notification.Name(rawValue: NOTIFICATION_APP_CLOSE), object: nil)
    }
    
    @IBAction func onBackPress(_ sender: Any) {
          dismiss(animated: false)
          
      }
    
    @IBAction func onBack(_ sender: Any) {
           dismiss(animated: false)
       
    }

}
