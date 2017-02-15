//
//  ProductData.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 15..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

//import Foundation
import UIKit
//


let DidReceiveTodayProductInfo = Notification.Name(rawValue: "DidReceiveTodayProduct")
class ProductData{
    
    static let sharedInstance = ProductData()
    
    
    //오늘의 상품
    var todayProducts: [Product]? {
        didSet {
            NotificationCenter.default.post(name: DidReceiveTodayProductInfo, object: nil)
        }
    }
    
}
