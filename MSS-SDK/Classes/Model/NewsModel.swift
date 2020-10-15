//
//  NewsModel.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 15/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import Foundation


struct NewsModel : Codable{
    public var author : String!
    public var title : String!
    public var description : String!
    public var url : String!
    public var urlToImage : String!
    public var publishedAt : String!
    public var content : String!
    public var source : NewsSource!
    
 
    static var newsListInstance = Array<NewsModel>()
}


struct NewsSource : Codable{
    public var name : String!

}

struct NewsResponse : Codable{
    public var status : String!
    public var articles : Array<NewsModel>!
    
}



