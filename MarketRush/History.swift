//
//  History.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 21..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class History: Object{
    
    
    dynamic var listSaveDate: String = ""
    var listofItems: Results<ListofItems>!
    
    

    
}
