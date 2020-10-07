//
//  GiftCardDetailVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 07/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit

class GiftCardDetailVC: UIViewController {

    
    @IBOutlet weak var ivGift: UIImageView!
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvPRice: UILabel!
    @IBOutlet weak var tvHowToUse: UILabel!
    @IBOutlet weak var tvValidity: UILabel!
    @IBOutlet weak var tvDescription: UILabel!
    
    
    var obtModel : GiftCardModel?  = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    

    @IBAction func onBackPress(_ sender: Any) {
        dismiss(animated: false)
        
    }
    

}
