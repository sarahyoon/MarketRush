//
//  HistoryList.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 21..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//
//
import Foundation
import RealmSwift
import Realm

class HistoryList: Object{
    
    dynamic var listSaveDate: String = ""
    //var list: List<ListofItems>!
    var list: Results<ListofItems>!
    
  func saveList(listSaveDate: String, listsofItems: Results<ListofItems>){
    

    
    let history = HistoryList()
    
        history.list = listsofItems
        history.listSaveDate = listSaveDate
    
        do{
            let realm = try? Realm()
            try realm?.write{
                realm?.add(history)
                print("ok")
            }
        }catch{
            print("realm add error")
        }
    }
    
}
