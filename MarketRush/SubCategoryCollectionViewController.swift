//
//  SubCategoryCollectionViewController.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 16..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SubCategoryCollectionViewController: UICollectionViewController {

    var selectedCategory: String!
    
    //section
    var meatSection = ["돼지고기","소고기","닭고기"]
    var drinkSection = ["생수/탄산수", "커피","차"]
    var dairySection = ["우유/두유", "치즈", "요구르트"]
    
//    //Instance
//    var vegeProduct = ProductData.sharedInstance.vegeProducts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedCategory)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveProductInfo(noti:)), name: DidReceiveProductInfo, object: nil)
        
        callProductApi(query: "채소", start: 2, display: 20)
        
        

        
    }
    
    //remove observer
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: DidReceiveProductInfo, object: nil)
    }
    
    func didReceiveProductInfo(noti: Notification) {
        self.collectionView?.reloadData()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
            return ProductData.sharedInstance.mrProducts!.count
        }

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCell", for: indexPath) as! SubCategoryCollectionViewCell
        cell.product = ProductData.sharedInstance.mrProducts?[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SubCategoryHeader", for: indexPath as IndexPath) as! SubCategoryHeaderCollectionReusableView
        
        header.subCategoryTitle.text = selectedCategory
       
        return header
    }
    


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
