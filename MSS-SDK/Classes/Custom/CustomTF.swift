//
//  CustomTF.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 06/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class CustomTF: SkyFloatingLabelTextField {
    

    override func awakeFromNib() {
        tintColor = ColorConverter.hexStringToUIColor(hex: ColorCode.accentColor)
        textColor = ColorConverter.hexStringToUIColor(hex: ColorCode.textDarkColor)
        lineColor = ColorConverter.hexStringToUIColor(hex: ColorCode.textDarkColor)
        
        selectedTitleColor = ColorConverter.hexStringToUIColor(hex: ColorCode.accentColor)
        selectedLineColor = ColorConverter.hexStringToUIColor(hex: ColorCode.accentColor)
        
        lineHeight = 1.0 // bottom line height in points
        selectedLineHeight = 1.0
        
    }
    
    
}
