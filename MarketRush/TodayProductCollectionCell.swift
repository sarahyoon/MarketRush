//
//  TodayProductCollectionCell.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 15..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit
import AlamofireImage

class TodayProductCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var todayProductImage: UIImageView!
    @IBOutlet weak var todayProductName: UILabel!
    
    //오늘의 상품 데이터주소 불러와 담기
    var item: Item? = nil{
        
        //product 값이 변경된 직후에 호출
        didSet{
            if let product = item,
                let url = URL(string: product.item_image!){
                
                self.todayProductImage.af_setImage(withURL: url, completion: {
                    (image) in
                    self.todayProductImage.image = image.result.value
                })
                
            }
            //todayProductImage.layer.borderWidth = 1.0
            
            let string = item?.item_title?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
            
            self.todayProductName.text = string
        }
    }

    
}

