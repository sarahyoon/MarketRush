//
//  Product.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 15..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RealmSwift
import Realm

class Item: Object, Mappable{
    
    //item data from api
    dynamic var item_title: String?
    dynamic var item_price: String?
    dynamic var item_image: String?
    dynamic var item_mallName: String?
    dynamic var item_id: String?
    
    //number of item, default as 1
    dynamic var item_amount: Int = 1
    
    
    

    //Implement of Mappable protocol
    required convenience init?(map: Map)
    {
        self.init()
        self.item_title = ""
        self.item_image = ""
        self.item_mallName = ""
        self.item_price = ""
        self.item_amount = 1
        self.item_id = ""
    }
    
    func mapping(map: Map) {
        self.item_title <- map["title"]
        self.item_price <- map["lprice"]
        self.item_image <- map["image"]
        self.item_mallName <- map["mallName"]
        self.item_id <- map["productId"]
        self.item_amount <- map["item_amount"]
    }
    
    
    //set item_id as a primary key
    override static func primaryKey() -> String?
    {
        return "item_id"
    }

    
}


//api 호출
func callProductApi(query:String, start:NSNumber, display:NSNumber)
{
    let shoppingURL = "https://openapi.naver.com/v1/search/shop.json"
    let headers = [
        "X-Naver-Client-Id": "AR2eGsj85wcPR0UBwrve",
        "X-Naver-Client-Secret": "LgcsMjKGBx"
    ]
    var parameters:[String:AnyObject] = [
        "sort" : "date" as AnyObject
    ]
    
    parameters["query"] = query as AnyObject?
    parameters["start"] = start
    parameters["display"] = display
    
    Alamofire.request(shoppingURL, parameters: parameters, headers: headers).responseObject { (response:DataResponse<Query>) in
        let product = response.result.value
        DataController.sharedInstance().items = product?.items
        
    }
}



