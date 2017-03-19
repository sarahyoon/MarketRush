//
//  AlertViewSetup.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 3. 20..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RealmSwift
import Realm

var item: Item!
var itemList = ListofItems()

//change title color and font
func changeTitleSet() ->NSMutableAttributedString{
    let myTitle  = "상품이 장바구니에 담겼습니다."
    var myMutableString = NSMutableAttributedString()
    myMutableString = NSMutableAttributedString(string: myTitle as String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 16.0)!])
    
    return myMutableString
}

