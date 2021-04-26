//
//  StaticData.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 06/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import Foundation
import UIKit

class StaticData{

static func getHomeMenu() -> [MenuModel]{
        var itemsArray = [MenuModel]()
    itemsArray.append(MenuModel.init(image:"menu_mobile", title: "MOBILE"))
    itemsArray.append(MenuModel.init(image:"menu_dth", title: "DTH"))
//    itemsArray.append(MenuModel.init(image:"menu_gift", title: "GIFT CARD"))
    itemsArray.append(MenuModel.init(image:"menu_news", title: "NEWS"))
//    itemsArray.append(MenuModel.init(image:"menu_bus", title: "BUS"))
    itemsArray.append(MenuModel.init(image:"menu_flight", title: "FLIGHTS"))
//    itemsArray.append(MenuModel.init(image:"menu_hotel", title: "HOTEL"))
//    itemsArray.append(MenuModel.init(image:"menu_cab", title: "CABS"))
//    itemsArray.append(MenuModel.init(image:"menu_grocery", title: "GROCERY"))


        return itemsArray
    }

}
