//
//  SubCategoryCollectionViewCell.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 16..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit

class SubCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var subCategoryImage: UIImageView!
    @IBOutlet weak var subCategoryImageName: UILabel!
    
    //오늘의 상품 데이터주소 불러와 담기
    var item: Item? = nil{
        
        //product 값이 변경된 직후에 호출
        didSet{
            if let product = item,
                let url = URL(string: product.item_image!){
                
                self.subCategoryImage.af_setImage(withURL: url, completion: {
                    (image) in
                    self.subCategoryImage.image = image.result.value
                })
                
            }
            //todayProductImage.layer.borderWidth = 1.0
            self.subCategoryImageName.text = item?.item_title
            
        }
    }
}
