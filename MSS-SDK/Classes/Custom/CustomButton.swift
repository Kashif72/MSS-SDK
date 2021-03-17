//
//  CustomButton.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 06/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class CustomButton: UIButton {
    
    override func awakeFromNib() {
        let gradientLayer1 = CAGradientLayer()
        gradientLayer1.colors = [ColorConverter.hexStringToUIColor(hex: ColorCode.btnOne).cgColor,ColorConverter.hexStringToUIColor(hex: ColorCode.btnThree).cgColor]
        gradientLayer1.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer1.endPoint = CGPoint(x: 1.5, y: 1.5)
        gradientLayer1.frame.size.height = self.bounds.height
        gradientLayer1.frame.size.width = self.bounds.width
        gradientLayer1.cornerRadius = 20
        self.layer.insertSublayer(gradientLayer1, at: 0)
        
        
    }

    
}

@IBDesignable
class CustomButtonRed: UIButton {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 1.0
        self.backgroundColor = ColorConverter.hexStringToUIColor(hex: ColorCode.btnOne)
        self.setTitleColor(ColorConverter.hexStringToUIColor(hex: ColorCode.textWhiteColor), for: .normal)
    }

    
}
