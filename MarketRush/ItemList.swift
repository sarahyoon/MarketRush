//z
//  ProductList.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 17..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class ItemList: Object{
    
    dynamic var item_id = ""
    //let items = List<Item>()
    var items: Results<Item>!
    
    //create
    func create(item_title: String, item_image: String, item_mallName: String, item_price: String, item_amount: Int, item_selectedDate: NSDate, item_id: String, isSaved: Bool)
    {
        
        let item = Item()
        
        item.item_title = item_title
        item.item_image = item_image
        item.item_mallName = item_mallName
        item.item_price = item_price
        item.item_amount = item_amount
        item.item_selectedDate = item_selectedDate
        item.item_id = item_id
        item.isSaved = isSaved
        
        do {
            let realm = try? Realm()
            try realm?.write {
                realm?.add(item)
                item.isSaved = true
                print("ok")
            }
        } catch {
            print("realm add error")
        }
    }
    
//    //delete
//    func delete(index: Int){
//        do{
//            try realm?.write{
//                let realm = try? Realm()
//                realm?.delete((items[index]))
//                
//            }}
//        
//        catch{
//            print("realm delete error!")
//        }
//    }
//
//    func update(todo: ToDo?, name: String, deadline: String, completionOption : String, memoText: String) {
//        do {
//            let realm = try Realm()
//            try realm.write {
//                todo?.planTitle = name
//                todo?.deadLineNumber = deadline
//                todo?.TimeOfCompletion = completionOption
//                todo?.memo = memoText
//                // todo?.isComplete = isCompleted
//            }
//        } catch {
//            print("update error")
//        }
//    }
}
