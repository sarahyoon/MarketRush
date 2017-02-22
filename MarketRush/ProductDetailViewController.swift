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

    //button outlet
    @IBOutlet weak var saveItemtoListButton: UIButton!
    
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
            
            let string = item?.item_title?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
            cell.productName.text = string
            
            cell.price.text = "가격"
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            let priceInt = Int(item.item_price!)
            cell.productPrice.text = numberFormatter.string(from: NSNumber(value: priceInt!))

            cell.mallName.text = "쇼핑몰"
            cell.productMall.text = item.item_mallName

            return cell
            
        }
    }
    
    @IBAction func saveItemToList(_ sender: Any) {
        //알림창 3초후에 사라지기로 변경!
        
        //장바구니에 새로 담은 제품일 경우
        if ((ifIdExists(findId: item.item_id!)) == nil){
            
            ListofItems().saveItem(item_title: item.item_title!, item_image: item.item_image!, item_mallName: item.item_mallName!, item_price: item.item_price!, item_amount: item.item_amount, item_id: item.item_id!)
            
            let alertController: UIAlertController = UIAlertController(title: "", message: "선택한 상품이 장바구니에 담겼습니다!!", preferredStyle: .alert)
            
            let action_cancel = UIAlertAction.init(title: "확인", style: .cancel)
            {   (UIAlertAction) -> Void in
                
                self.saveItemtoListButton.isHidden = true
                self.tabBarController?.tabBar.isHidden = false
            }
            
            alertController.addAction(action_cancel)
            present(alertController, animated: true, completion: nil)
            
        }
            
            //이미 장바구니에 담은 제품일 경우
        else{
            
            self.saveItemtoListButton.isHidden = true

            let alertController: UIAlertController = UIAlertController(title: "", message: "이미 선택하신 제품입니다.", preferredStyle: .alert)
            let action_cancel = UIAlertAction.init(title: "계속 쇼핑하기", style:.cancel){
                (UIAlertAction) -> Void in }
            
            alertController.addAction(action_cancel)
            present(alertController, animated: true, completion: nil)
        }

    }

    
    //product ID 확인
    func ifIdExists(findId: String) -> Item?{
        
        let predicate = NSPredicate(format: "item_id = %@", findId)
        let realm = try? Realm()
        let object = realm?.objects(Item.self).filter(predicate).first
        if object?.item_id == findId {
            
            return object
            
        }
        return nil
    }
    

}
