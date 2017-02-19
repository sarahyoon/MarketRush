//
//  Products.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 15..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class Query: Mappable{
    var items: [Item]?
    
    required init?(map:Map)
    {
        
    }
    
    func mapping(map: Map) {
        self.items <- map["items"]
        
    }
}
