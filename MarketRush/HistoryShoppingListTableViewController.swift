//
//  HistoryShoppingListTableViewController.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 18..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryShoppingListTableViewController: UITableViewController  {

    var listofItems = ListofItems()
    var item: Item?
    let realm = try? Realm()
    
    var historyList = HistoryList()
    var dates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.historyList.list = realm?.objects(ListofItems.self)

        dates = ["Today", "20 Febuary, 2017", "19 Febuary, 2017"]
        
    //
   //     print("historyview\(self.historyList.listSaveDate)")
//        self.tabBarController?.tabBar.isHidden = false
        
//        let sortedItem = realm?.objects(Item.self).filter{$0.item_selectedDate != nil}.sorted { ($0.item_selectedDate!) as Date > ($1.item_selectedDate!) as Date}
       // self.itemList.items = sortedItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        
//        let listNum = realm?.objects(HistoryList.self).filter("listSaveDate.@count > 0")
//        
//        return (listNum?.count)!
        print(historyList.list.count)
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryShoppingListTableViewCell", for: indexPath) as! HistoryShoppingListTableViewCell
        
  //      cell.listSavedDate.text = "\(self.historyList.listSaveDate)"
        cell.listSavedDate.text = dates[indexPath.row]

        return cell
    }
    

//    func saveDate() -> String {
//        let history = [HistoryList]()
//        self.history = realm?.objects(historyList.self)
//        
//        
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
