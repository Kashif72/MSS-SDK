//
//  Constant.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 06/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import Foundation


let SUCCESS = "S00"

let NETWORK_FAIL_MSG  = "Network is not available now"


let ERR_THIS_FILED_IS_REQ = "This field is required"
let ERR_MOBILE = "Invalid mobile number"


//URLS

let URL_GET_ALL_OP_CR = "topUp/getCircleOperator"
let URL_GET_PREPAID_OP_CIR = "topUp/getCircleOperator"
let URL_AUTO_OPT = "topUp/getTelcoMobile"
//let URL_BROWSE_PLAN = "topUp/browsePlan"
let URL_GET_PLANS = "topUp/browsePlan"
let URL_GET_GIFT_CARDS_CAT = "giftCard/fetch/categoryList"
let URL_GET_GIFT_CARDS_LIST = "giftCard/fetch/voucher/list"


let URL_GET_NEWS = "https://newsapi.org/v2/top-headlines?country=in&apiKey=2c3d1a14d004414aa3f0f8e85a13206e"


//**************Travel**************
let URL_GET_BUS_CITY_LIST = "travel/bus/cityList"
let URL_GET_BUS_LIST = "/travel/bus/getAvailableTrips"


//NOTIFICATION

public let NOTIFACTION_REQUEST = "requestSent"
public let REQUEST_TYPE = "requestType"
public let REQUEST_DATA = "requestData"


public let NOTIFICATION_APP_LIFE = "app_life"
public let NOTIFICATION_APP_CLOSE = "app_close"
