//
//  ProductDetailViewController.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 16..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class ProductDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var item: Item!
        //var items: Results<Item>!
    
    var list = ["상품이름", "가격", "쇼핑몰이름"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //4
        return self.list.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailImageCell") as! DetailImageTableViewCell
            if let url = NSURL(string:item.item_image!){
                cell.productimage.af_setImage(withURL: url as URL)
            }
            return cell
        }
        else{ // row == 1
            
            //let row = self.list[indexPath.row] //2번째 row부터
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailDescriptionCell") as! DetailDescriptionTableViewCell
            
            cell.productName.text = item.item_title
            cell.price.text = "가격"
            cell.productPrice.text = item.item_price
            cell.mallName.text = "쇼핑몰"
            cell.productMall.text = item.item_mallName

            return cell
            
        }
    }
    

    @IBAction func itemsToList(_ sender: Any) {

        item.item_selectedDate = getCurrentDate() as NSDate?
        
        
        if ((ifIdExists(findId: item.item_id!)) == nil){
            
            ItemList().create(item_title: item.item_title!, item_image: item.item_image!, item_mallName: item.item_mallName!, item_price: item.item_price!, item_amount: item.item_amount, item_selectedDate: item.item_selectedDate!, item_id: item.item_id!, isSaved: item.isSaved)
            
            let alertController: UIAlertController = UIAlertController(title: "", message: "선택한 상품이 장바구니에 담겼습니다!!", preferredStyle: .alert)
            
            let action_cancel = UIAlertAction.init(title: "계속 쇼핑하기", style: .cancel)
            {   (UIAlertAction) -> Void in }
                alertController.addAction(action_cancel)
          
            let action_add = UIAlertAction.init(title: "장바구니 확인", style:.default)
            {
                (UIAlertAction) -> Void in
                
                let storyBoard = UIStoryboard(name:"Main", bundle: nil)
                let gotoDetailShoppingListView = storyBoard.instantiateViewController(withIdentifier: "DetailShoppingListViewController") as! DetailShoppingListViewController
//                let realm = try? Realm()
//               gotoDetailShoppingListView.items = realm?.objects(Item.self)
                self.navigationController?.pushViewController(gotoDetailShoppingListView, animated: true)
            }
            
            alertController.addAction(action_add)
            present(alertController, animated: true, completion: nil)
        }
        
        else{
            let alertController: UIAlertController = UIAlertController(title: "", message: "이미 선택하신 제품입니다.", preferredStyle: .alert)
            let action_cancel = UIAlertAction.init(title: "계속 쇼핑하기", style:.cancel){
                (UIAlertAction) -> Void in }
            alertController.addAction(action_cancel)
            
            let action_add = UIAlertAction.init(title: "장바구니 확인", style: .default)
            {  (UIAlertAction) -> Void in
                
                let storyBoard = UIStoryboard(name:"Main", bundle: nil)
                let gotoDetailShoppingListView = storyBoard.instantiateViewController(withIdentifier: "DetailShoppingListViewController") as! DetailShoppingListViewController
                self.navigationController?.pushViewController(gotoDetailShoppingListView, animated: true)
            }
                alertController.addAction(action_add)
                present(alertController, animated: true, completion: nil)
            }
    }
        
//        //새로 선택한 제품
//        if (item.isSaved == false)
//        {
//            ItemList().create(item_title: item.item_title!, item_image: item.item_image!, item_mallName: item.item_mallName!, item_price: item.item_price!, item_amount: item.item_amount, item_selectedDate: item.item_selectedDate!, item_id: item.item_id!, isSaved: item.isSaved)
//            
//            let alertController : UIAlertController = UIAlertController(title: "", message: "선택한 상품이 장바구니에 담겼습니다.", preferredStyle: .alert)
//            let action_cancel = UIAlertAction.init(title: "계속 쇼핑하기", style: .cancel)
//            { (UIAlertAction) -> Void in
//            }
//            alertController.addAction(action_cancel)
//            
//            
//            let action_add = UIAlertAction.init(title: "장바구니 확인", style: .default)
//            {
//                (UIAlertAction) -> Void in
//                
//                let storyBoard = UIStoryboard(name:"Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailShoppingListViewController") as! DetailShoppingListViewController
//                nextViewController.items = realm.objects(Item.self)
//                self.navigationController?.pushViewController(nextViewController, animated: true)
//            }
//            
//            alertController.addAction(action_add)
//            present(alertController, animated: true, completion: nil)
//        }
//        
//        //if item.isSaved == false
//        else {
//                let alertController: UIAlertController = UIAlertController(title: "", message: "이미 선택하신 제품입니다.", preferredStyle: .alert)
//            
//                        let action_cancel = UIAlertAction.init(title: "계속 쇼핑하기", style: .cancel) { (UIAlertAction) -> Void in
//                        }
//                        alertController.addAction(action_cancel)
//            
//                        let action_add = UIAlertAction.init(title: "장바구니 확인", style: .default)
//                        {
//                            (UIAlertAction) -> Void in
//                            let storyBoard = UIStoryboard(name:"Main", bundle:nil)
//                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailShoppingListViewController") as! DetailShoppingListViewController
//            //                   nextViewController.product = self.product
//            
//                            self.navigationController?.pushViewController(nextViewController, animated: true)
//                        }
//            alertController.addAction(action_add)
//            present(alertController, animated: true, completion: nil)
//        }

//    }
    
    
    func getCurrentDate() -> Date {
        
        var now:Date = Date()
        var calendar = Calendar.current
        let timezone = NSTimeZone.system
        calendar.timeZone = timezone
        //timezone을 사용해서 date의 components를 지정해서 가져옴.
        let anchorComponets = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: now)
        
        let getDateFromDateComponents = calendar.date(from: anchorComponets)
        if let getCurrentDate = getDateFromDateComponents {
            now = getCurrentDate
        }
        return now
    }
    
    func ifIdExists(findId: String) -> Item?{
        
        let predicate = NSPredicate(format: "item_id = %@", findId)
        let realm = try? Realm()
        let object = realm?.objects(Item.self).filter(predicate).first
        if object?.item_id == findId {
            
            return object
            
        }
        return nil
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
