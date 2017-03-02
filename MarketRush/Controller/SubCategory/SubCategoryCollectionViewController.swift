//
//  SubCategoryCollectionViewController.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 16..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit
import RealmSwift
import MIBadgeButton_Swift

private let reuseIdentifier = "Cell"

class SubCategoryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var cartBadge: MIBadgeButton!
    
    
    var selectedCategory: String!
    
    var item: Item!
    let realm = try? Realm()
    var itemList = ListofItems()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Number of total items in cart
        updateTotalItem()
        self.navigationItem.rightBarButtonItem?.didChangeValue(forKey: cartBadge.badgeString!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveProductInfo(noti:)), name: DidReceiveProductInfo, object: nil)

        //Send different query by selected category
        switch selectedCategory {
            
        case Constants.VEGE:
            return callProductApi(query: "산지직송+채소", start: 1, display: 20)
            
        case Constants.BREAD:
            return callProductApi(query: "빵", start: 3, display: 20)
            
        case Constants.DAIRY:
            return callProductApi(query: "치즈+우유", start: 1, display: 20)
            
        case Constants.DRINK:
            return callProductApi(query: "커피+녹차+홍차+차류", start: 1, display: 20)
            
        case Constants.FRUIT:
            return callProductApi(query: "과일+산지직송", start: 1, display: 20)
            
        case Constants.MEAT:
            return callProductApi(query: "축산+산지직송", start: 1, display: 20)
            
        case Constants.NOODLES:
            return callProductApi(query: "면류+쌀", start: 1, display: 20)
            
        default:
            return callProductApi(query: "견과류", start: 1, display: 20)
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemList.items = realm?.objects(Item.self)

        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.done, target: self, action: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: DidReceiveProductInfo, object: nil)
    }
    
    func didReceiveProductInfo(noti: Notification) {
        self.collectionView?.reloadData()
    }

    func updateTotalItem()
    {
        let myitem = self.itemList.items
        cartBadge.badgeString = (myitem?.count)?.description
        print("cartBagde: \(cartBadge.badgeString)")
        cartBadge.badgeEdgeInsets = UIEdgeInsetsMake(13, 5, 0, 0)
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //goto Product Detail View Controller from selected items
        if (segue.identifier == "gotoDetailViewFromSub"){
            if let subCategoryImageCell = sender as? SubCategoryCollectionViewCell, let detailProductView = segue.destination as? ProductDetailViewController{
                let product = subCategoryImageCell.item
                detailProductView.item = product
            }
        }
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCell", for: indexPath) as! SubCategoryCollectionViewCell
        
        cell.cartButton.addTarget(self,action: #selector(itemToCart(_:)),for: .touchUpInside)
        cell.item = DataController.sharedInstance().items?[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSpace: CGFloat = 10.0 * 3 // 셀 사이 간격 3개
        
        let cellWidth = (collectionView.bounds.size.width - cellSpace) / 2.0
        let cellSize = CGSize(width: cellWidth, height: cellWidth + 40)
        
        return cellSize
    }
    
    //Sub Category Header view
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SubCategoryHeader", for: indexPath as IndexPath) as! SubCategoryHeaderCollectionReusableView
        
        header.subCategoryTitle.text = selectedCategory
        header.subCategoryTitle.textColor = UIColor.gray
        header.subCategoryTitle.font = UIFont.boldSystemFont(ofSize: 18.0)
        header.backgroundColor = UIColor(red: 239/255, green: 240/255, blue: 241/255, alpha: 1.0)
       
        return header
    }
    
    //put item in cart button
    @IBAction func itemToCart(_ sender: Any) {
        
        let indexPath = collectionView?.indexPath(for: (((sender as AnyObject).superview??.superview) as! SubCategoryCollectionViewCell))
        
        let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: "SubCategoryCell", for: indexPath!) as! SubCategoryCollectionViewCell
        cell.item = DataController.sharedInstance().items?[(indexPath?.row)!]
    
        //new item
        if (ifIdExists(findId: (cell.item?.item_id)!) == nil){

        ListofItems().saveItem(item_title: (cell.item?.item_title!)!, item_image: (cell.item?.item_image!)!, item_mallName: (cell.item?.item_mallName!)!, item_price: (cell.item?.item_price!)!, item_amount: (cell.item?.item_amount)!, item_id: (cell.item?.item_id!)!)
            
            let string = cell.item?.item_title?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
            let alertController = UIAlertController(title: "상품이 장바구니에 담겼습니다.", message: string, preferredStyle: UIAlertControllerStyle.alert)
            
            // Background color.
            let backView = alertController.view.subviews.last?.subviews.last
            backView?.layer.cornerRadius = 10.0
            
            // Change Title With Color and Font:
            let myTitle  = "상품이 장바구니에 담겼습니다."
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myTitle as String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 16.0)!])
            alertController.setValue(myMutableString, forKey: "attributedTitle")
            
            // Change Message With Color and Font
            let message  = string
            var messageMutableString = NSMutableAttributedString()
            messageMutableString = NSMutableAttributedString(string: message! as String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!])
            messageMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 55/255, green: 142/255, blue: 109/255, alpha: 1.0), range: NSRange(location:0,length:(message?.characters.count)!))

            alertController.setValue(messageMutableString, forKey: "attributedMessage")
            
            // Action.
            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
            updateTotalItem()
            self.navigationItem.rightBarButtonItem?.didChangeValue(forKey: cartBadge.badgeString!)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            
        }
            
        //items already in cart
        else{
            
            let alertController: UIAlertController = UIAlertController(title: "", message: "이미 선택하신 제품입니다.", preferredStyle: .alert)
            let action_cancel = UIAlertAction.init(title: "계속 쇼핑하기", style:.cancel){
                            (UIAlertAction) -> Void in }
            
            alertController.addAction(action_cancel)
            present(alertController, animated: true, completion: nil)
            }
        
        }

    
    //check product id
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


