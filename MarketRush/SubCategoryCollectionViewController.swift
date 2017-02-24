//
//  SubCategoryCollectionViewController.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 16..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class SubCategoryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var cartButton: UIButton!
    var selectedCategory: String!
    
    //section
    var meatSection = ["돼지고기","소고기","닭고기"]
    var drinkSection = ["생수/탄산수", "커피","차"]
    var dairySection = ["우유/두유", "치즈", "요구르트"]
    
    var item: Item!
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSpace: CGFloat = 10.0 * 3 // 셀 사이 간격 3개
        
        let cellWidth = (collectionView.bounds.size.width - cellSpace) / 2.0
        let cellSize = CGSize(width: cellWidth, height: cellWidth + 40)
        
        return cellSize
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveProductInfo(noti:)), name: DidReceiveProductInfo, object: nil)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.done, target: self, action: nil)
        
        
        //셀렉티드 카테고리별로 쿼리 다르게 날리기!
        
        switch selectedCategory {
            
        case Constants.VEGE:
            
            return callProductApi(query: "샐러드", start: 2, display: 20)
            
        case Constants.BREAD:
            
            return callProductApi(query: "식빵", start: 3, display: 20)
            
        case Constants.DAIRY:
            
            return callProductApi(query: "치즈", start: 1, display: 20)
            
        case Constants.DRINK:
            return callProductApi(query: "커피", start: 1, display: 20)
            
        case Constants.FRUIT:
            return callProductApi(query: "과일", start: 1, display: 20)
        
        default:
            return callProductApi(query: "소고기", start: 1, display: 20)
        }

        
    }
    
    //remove observer
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: DidReceiveProductInfo, object: nil)
    }
    
    func didReceiveProductInfo(noti: Notification) {
        self.collectionView?.reloadData()
    }

    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
        if (segue.identifier == "gotoDetailViewFromSub"){
            if let subCategoryImageCell = sender as? SubCategoryCollectionViewCell, let detailProductView = segue.destination as? ProductDetailViewController{
                let product = subCategoryImageCell.item
                detailProductView.item = product
            }
        }
    }


    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        switch selectedCategory {
//            
//        case Constants.MEAT:
//            return meatSection.count
//            
//        case Constants.DRINK:
//            return drinkSection.count
//            
//        case Constants.DAIRY:
//            return dairySection.count
//            
//        default:
//            return (vegeProduct?.count)!
//        }
//
//    }
//    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch selectedCategory {
            
        case Constants.MEAT:
            return meatSection.count
            
        case Constants.DRINK:
            return drinkSection.count
            
        case Constants.DAIRY:
            return dairySection.count
            
        default:
            return (DataController.sharedInstance().items?.count)!
        }

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCell", for: indexPath) as! SubCategoryCollectionViewCell
        
        cell.cartButton.addTarget(self,action: #selector(itemToCart(_:)),for: .touchUpInside)
        cell.item = DataController.sharedInstance().items?[indexPath.row]
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SubCategoryHeader", for: indexPath as IndexPath) as! SubCategoryHeaderCollectionReusableView
        
        header.subCategoryTitle.text = selectedCategory
        header.subCategoryTitle.textColor = UIColor.gray
        header.subCategoryTitle.font = UIFont.boldSystemFont(ofSize: 18.0)
        header.backgroundColor = UIColor(red: 239/255, green: 240/255, blue: 241/255, alpha: 1.0)
       
        return header
    }
    

    @IBAction func itemToCart(_ sender: Any) {
        
        let indexPath = collectionView?.indexPath(for: (((sender as AnyObject).superview??.superview) as! SubCategoryCollectionViewCell))
        
        let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: "SubCategoryCell", for: indexPath!) as! SubCategoryCollectionViewCell
        
        cell.item = DataController.sharedInstance().items?[(indexPath?.row)!]
    
        if (ifIdExists(findId: (cell.item?.item_id)!) == nil){
            
            print("new item")

        ListofItems().saveItem(item_title: (cell.item?.item_title!)!, item_image: (cell.item?.item_image!)!, item_mallName: (cell.item?.item_mallName!)!, item_price: (cell.item?.item_price!)!, item_amount: (cell.item?.item_amount)!, item_id: (cell.item?.item_id!)!)
        
        let string = cell.item?.item_title?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        let alertController: UIAlertController = UIAlertController(title: string, message: "선택한 상품이 장바구니에 담겼습니다!!", preferredStyle: .alert)
        
        let action_cancel = UIAlertAction.init(title: "확인", style: .cancel)
        {   (UIAlertAction) -> Void in
        
        }
        
        alertController.addAction(action_cancel)
        present(alertController, animated: true, completion: nil)
                    
        }
            
        else{
            print("already exists")
            
            let alertController: UIAlertController = UIAlertController(title: "", message: "이미 선택하신 제품입니다.", preferredStyle: .alert)
            let action_cancel = UIAlertAction.init(title: "계속 쇼핑하기", style:.cancel){
                            (UIAlertAction) -> Void in }
            
            alertController.addAction(action_cancel)
            present(alertController, animated: true, completion: nil)
            }
        
        }

    
//    product ID 확인
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


