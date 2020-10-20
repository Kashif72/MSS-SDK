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
    }
    
    @IBAction func onBackPress(_ sender: Any) {
          dismiss(animated: false)
          
      }

}
