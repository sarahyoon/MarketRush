//
//  TodayProduct.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 24..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import Foundation
import RealmSwift

class TodayProduct: Object{
    
    dynamic var item_title: String?
    dynamic var item_price: String?
    dynamic var item_image: String?
    dynamic var item_mallName: String?
    dynamic var item_id: String?
    dynamic var item_amount: Int = 1
    
}

