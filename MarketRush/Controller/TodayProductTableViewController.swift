//
//  TodayProductTableViewController.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 25..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class TodayProductTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var lists = Array<TodayProduct>()
    //var item = [Item]()
    //    var items: Results<Item>!
    
    var list = ["상품이름", "가격", "쇼핑몰이름"]
    var section = ["1", "2"]
    
    var todayImage = ["strawberry.png","namul.png","chicken.png","juice.png","noodles.png","rice.png"]
    var todayTitle = ["친환경 하우스 딸기(설향)","친환경 봄나물 4종","[백년대계] 닭가슴살","콜드프레스 주스 6종","[마에스트리] 아티장 파스타 7종","게르마늄 쌀 2종"]
    var todayPrice = ["8500","2100","4200","7500","6900","9500"]
    var todayMall = ["당일수확, 당일배송되는 단단하고 상큼한 설향 딸기(1팩, 500g내외)", "봄 내음 가득한 봄나물 달래, 냉이, 세발나물, 방풍나물","무항생제 친환경 닭고기 가슴살 (300g)","영양소 파괴없이 정성껏 짜낸 콜드프레스 주스","[컬리 단독수입]이탈리안 파스타의 자부심","인체에 유익한 게르마늄 성분과 쌀눈이 살아있는 맛있고 영양넘치는 게르마늄 쌀"]
    
    
    
    //button outlet
    @IBOutlet weak var saveItemtoListButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 239/255, green: 240/255, blue: 241/255, alpha: 0.4)
        
        //딸기
        var todayItem = TodayProduct()
        todayItem.item_id = "1"
        todayItem.item_image = "strawberry.png"
        todayItem.item_title = "친환경 하우스 딸기(설향)"
        todayItem.item_price = "8500"
        todayItem.item_mallName = "당일수확, 당일배송되는 단단하고 상큼한 설향 딸기(1팩, 500g내외)"
        todayItem.item_amount = 1
        
        self.lists.append(todayItem)
        
        
        //봄나물
        todayItem = TodayProduct()
        todayItem.item_id = "2"
        todayItem.item_image = "namul.png"
        todayItem.item_title = "[백년대계] 닭가슴살"
        todayItem.item_price = "7500"
        todayItem.item_mallName = "봄 내음 가득한 봄나물 달래, 냉이, 세발나물, 방풍나물"
        todayItem.item_amount = 1
        
        self.lists.append(todayItem)
        
        //닭가슴살
        todayItem = TodayProduct()
        todayItem.item_id = "3"
        todayItem.item_image = "chicken.png"
        todayItem.item_title = "친환경 봄나물 4종"
        todayItem.item_price = "4200"
        todayItem.item_mallName = "무항생제 친환경 닭고기 가슴살 (300g)"
        todayItem.item_amount = 1
        
        self.lists.append(todayItem)
        
        //주스
        todayItem = TodayProduct()
        todayItem.item_id = "4"
        todayItem.item_image = "juice.png"
        todayItem.item_title = "콜드프레스 주스 6종"
        todayItem.item_price = "7500"
        todayItem.item_mallName = "영양소 파괴없이 정성껏 짜낸 콜드프레스 주스"
        todayItem.item_amount = 1
        
        self.lists.append(todayItem)
        
        //면
        todayItem = TodayProduct()
        todayItem.item_id = "5"
        todayItem.item_image = "noodles.png"
        todayItem.item_title = "[마에스트리] 아티장 파스타 7종"
        todayItem.item_price = "6900"
        todayItem.item_mallName = "[컬리 단독수입]이탈리안 파스타의 자부심"
        todayItem.item_amount = 1
        
        self.lists.append(todayItem)
        
        //
        todayItem = TodayProduct()
        todayItem.item_id = "6"
        todayItem.item_image = "rice.png"
        todayItem.item_title = "게르마늄 쌀 2종"
        todayItem.item_price = "9500"
        todayItem.item_mallName = "인체에 유익한 게르마늄 성분과 쌀눈이 살아있는 맛있고 영양넘치는 게르마늄 쌀"
        todayItem.item_amount = 1
        
        self.lists.append(todayItem)

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //4
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.lists[indexPath.row]
       view.tag = indexPath.row
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailImageCell") as! DetailImageTableViewCell
            
            cell.productimage.image = UIImage(named: row.item_image!)
//            if let url = NSURL(string:item.item_image!){
//                cell.productimage.af_setImage(withURL: url as URL)
//            }
 
            return cell
        }
        else{ // row == 1
            
            //let row = self.list[indexPath.row] //2번째 row부터
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailDescriptionCell") as! DetailDescriptionTableViewCell
//            
//            let string = item?.item_title?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
            cell.productName.text = row.item_title
            
            cell.price.text = "가격"
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            let priceInt = Int(row.item_price!)
            cell.productPrice.text = numberFormatter.string(from: NSNumber(value: priceInt!))
            
            cell.mallName.text = "쇼핑몰"
            cell.productMall.text = row.item_mallName
            
            return cell
            
        }
    }
    
    @IBAction func saveItemToList(_ sender: AnyObject) {
        
        let row = self.lists[view.tag]
        
        //장바구니에 새로 담은 제품일 경우
        if ((ifIdExists(findId: row.item_id!)) == nil){
            
            ListofItems().saveItem(item_title: row.item_title!, item_image: row.item_image!, item_mallName: row.item_mallName!, item_price: row.item_price!, item_amount: row.item_amount, item_id: row.item_id!)
            
//            let string = row.item_title?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
            
            let alertController = UIAlertController(title: "상품이 장바구니에 담겼습니다.", message: row.item_title, preferredStyle: UIAlertControllerStyle.alert)
            
            // Background color.
            let backView = alertController.view.subviews.last?.subviews.last
            backView?.layer.cornerRadius = 10.0
            
            // Change Title With Color and Font:
            let myTitle  = "상품이 장바구니에 담겼습니다."
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myTitle as String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 16.0)!])
            alertController.setValue(myMutableString, forKey: "attributedTitle")
            
            // Change Message With Color and Font
            let message  = row.item_title
            var messageMutableString = NSMutableAttributedString()
            messageMutableString = NSMutableAttributedString(string: message! as String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!])
            messageMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 55/255, green: 142/255, blue: 109/255, alpha: 1.0), range: NSRange(location:0,length:(message?.characters.count)!))
            
            alertController.setValue(messageMutableString, forKey: "attributedMessage")
            
            // Action.
            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            
        }
            
            //이미 장바구니에 담은 제품일 경우
        else{
            
            saveItemtoListButton.titleLabel?.textColor = UIColor(red: 55, green: 142, blue: 109, alpha: 0.3)
            
            let alertController: UIAlertController = UIAlertController(title: "", message: "이미 선택하신 제품입니다.", preferredStyle: .alert)
            let action_cancel = UIAlertAction.init(title: "계속 쇼핑하기", style:.cancel){
                (UIAlertAction) -> Void in }
            
            alertController.addAction(action_cancel)
            present(alertController, animated: true, completion: nil)
        }

    }
     //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //
    //
    //
    //    }
    
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 5.0
    //
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 400.0
        }
        if indexPath.section == 1
        {
            return 200.0
        }
        else{
            return 45.0
        }
    }
    
    //product ID 확인
    func ifIdExists(findId: String) -> TodayProduct?{
        
        let predicate = NSPredicate(format: "item_id = %@", findId)
        let realm = try? Realm()
        let object = realm?.objects(TodayProduct.self).filter(predicate).first
        if object?.item_id == findId {
            
            return object
            
        }
        return nil
    }

    
}

extension UITableViewCell {
    
    var indexPath: IndexPath? {
        return (superview as? UITableView)?.indexPath(for: self)
    }
}
