//
//  DetailShoppingListViewController.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 17..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

//현재 장바구니에 담은 상품 리스트var기
class DetailShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailShoppingListTableViewCellDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    //1뷰
//    @IBOutlet weak var date: UILabel!
      @IBOutlet weak var itemNumber: UILabel!
    
    //2뷰
    @IBOutlet weak var totalSumLabel: UILabel!
    @IBOutlet weak var subTotalPrice: UILabel!
    
    let realm = try? Realm()
    
    //var items: Results<Item>!
    //var items = List<Item>()
    var item: Item?
    var itemList = ItemList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //self.items = realm?.objects(Item.self)
       self.itemList.items = realm?.objects(Item.self)
       updateTotalItem()

        //print(myitem?.count)
        
        
    NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveProductInfo(noti:)), name: DidReceiveProductInfo, object: nil)
        
        
        //date.text = realm?.objects(Item.self).value(forKey: "\(item.item_selectedDate)") as! String?
        //self.item = (realm?.object(ofType: Item.self, forPrimaryKey: item.item_id))!
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailShoppingListCell", for: indexPath) as! DetailShoppingListTableViewCell

        cell.productName.text = itemList.items[indexPath.row].item_title
        print(itemList.items[indexPath.row].item_id)
        cell.productPrice.text = itemList.items[indexPath.row].item_price
        
        cell.delegate = self
        
        if let url = NSURL(string:(itemList.items[indexPath.row].item_image!)){
            cell.productImage.af_setImage(withURL: url as URL)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete){
            let realm = try? Realm()
            do{
            try realm?.write{
                let item = itemList.items[indexPath.row]
                realm?.delete(item)
                }}
            catch{
                print("realm delete error!")
            }
            tableView.deleteRows(at:[indexPath], with: .automatic)
            updateTotalItem()
            
        }
        
}

    func didReceiveProductInfo(noti: Notification) {
        self.tableView.reloadData()
    }
    
    func updateTotalItem()
    {
        let myitem = self.itemList.items
        self.itemNumber.text = (myitem?.count)?.description
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        //날짜
        //해당 상품 이미지, 이름, 가격 저장, 총 수량 저장
        
        
    }
    
    

    func detailShoppingListTableViewCellDidChangeNumber(cell: DetailShoppingListTableViewCell) {
        
        if let indexPath = self.tableView.indexPath(for: cell) {
            
            realm?.beginWrite()
            
        self.itemList.items[indexPath.row].item_amount = Int(cell.numOfItemInput.text!)!
        self.itemList.items[indexPath.row].item_price = cell.productPrice.text
    
        try! realm?.commitWrite()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
