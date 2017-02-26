//
//  ProductData.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 15..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

//import Foundation
import UIKit



let DidReceiveProductInfo = Notification.Name(rawValue: "DidReceiveProduct")

class DataController{
    
    struct StaticInstance{
        static var instance: DataController?
    }

    
    class func sharedInstance() -> DataController {
        if !(StaticInstance.instance != nil){
            
            StaticInstance.instance = DataController()
        }
        
        return StaticInstance.instance!
    }
    
    var items: [Item]? = nil {
        
        didSet {
            
            NotificationCenter.default.post(name: DidReceiveProductInfo, object: nil)
            }
        }
}
