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


let DidReceiveProductInfo = Notification.Name(rawValue: "DidReceiveProduct")

class ProductData{
    
    static let sharedInstance = ProductData()
    
    
    
    var mrProducts: [Product]? {
        didSet {
            NotificationCenter.default.post(name: DidReceiveProductInfo, object: nil)
        }
    }
    
    
}
