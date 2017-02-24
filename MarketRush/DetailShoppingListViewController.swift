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

//현재 장바구니에 담은 상품 리스트
class DetailShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailShoppingListTableViewCellDelegate, UITextFieldDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabelView: UIView!
    
    //1뷰
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var itemNumber: UILabel!
    
    //2뷰
    @IBOutlet weak var totalSumLabel: UILabel!
    @IBOutlet weak var subTotalPrice: UILabel!
    
   // @IBOutlet weak var saveButton: UIButton!
    
    let realm = try? Realm()
    
    var item: Item?
    var itemList = ListofItems()

    //today Date
    var todayDate: String = "\(NSDate())"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.itemList.items = realm?.objects(Item.self)

        updateTotalItem()
        self.subTotalPrice.text = decimalFormat(num: "\(subTotal())")
        
        self.tableView.reloadData()
        
    NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveProductInfo(noti:)), name: DidReceiveProductInfo, object: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let today = getCurrentDate()
        self.date.text = today
        
        self.dateLabelView.bounds = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 60)
        self.dateLabelView.tintColor = UIColor.lightGray

        //date.text = realm?.objects(Item.self).value(forKey: "\(item.item_selectedDate)") as! String?
        //self.item = (realm?.object(ofType: Item.self, forPrimaryKey: item.item_id))!
        
//        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DetailShoppingListCell") as! DetailShoppingListTableViewCell
//        

    }
    
    func textFieldShouldReturn(numOfItemInput : UITextField) -> Bool
    {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DetailShoppingListCell") as! DetailShoppingListTableViewCell
        cell.numOfItemInput.resignFirstResponder()
        
        return true
    }
    

    func getCurrentDate() -> String
    {
        let currentDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let dateString = dateFormatter.string(from: currentDate as Date)
        
        return dateString
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(itemList.items.count)
        
        return itemList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailShoppingListCell", for: indexPath) as! DetailShoppingListTableViewCell
        
        
        
        let string = itemList.items[indexPath.row].item_title?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        cell.productName.text = string
       
        //단품가격 저장
        cell.priceForOne = Int(itemList.items[indexPath.row].item_price!)!
        
        
       cell.productPrice.text = decimalFormat(num: itemList.items[indexPath.row].item_price!)
        cell.delegate = self
        
        cell.numOfItemInput.text = "\(itemList.items[indexPath.row].item_amount)"
        
        if let url = NSURL(string:(itemList.items[indexPath.row].item_image!)){
            cell.productImage.af_setImage(withURL: url as URL)
        }
       // cell.numOfItemInput.delegate = self
        
        return cell
        
    }
    
    func decimalFormat (num:String)->String{
        let numberFormmater = NumberFormatter()
        numberFormmater.numberStyle = NumberFormatter.Style.decimal
        let priceInt = Int(num)
        
        return numberFormmater.string(from: NSNumber(value:priceInt!))!
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
            
            self.subTotalPrice.text = decimalFormat(num: "\(subTotal())")
            self.tableView.reloadData()
            
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
    
    func subTotal()-> Int
    {
        let sumArray:[String] = realm!.objects(Item.self).sorted(byKeyPath: "item_price").value(forKeyPath: "item_price") as! Array<String>
        let sumArrayofInt: [Int] = sumArray.map{Int($0) ?? 0}
        let sum = sumArrayofInt.reduce(0,+)
        
        return sum
        
    }
    

    func detailShoppingListTableViewCellDidChangeNumber(cell: DetailShoppingListTableViewCell) {
        
        if let indexPath = self.tableView.indexPath(for: cell) {
            
            realm?.beginWrite()
            
        self.itemList.items[indexPath.row].item_amount = Int(cell.numOfItemInput.text!)!
        self.itemList.items[indexPath.row].item_price = cell.productPrice.text
        
        self.subTotalPrice.text = "\(subTotal())"
        
        try! realm?.commitWrite()
        }
        cell.productPrice.text = decimalFormat(num: "\(cell.price)")
        self.subTotalPrice.text = decimalFormat(num:"\(subTotal())")
    }
    


}
