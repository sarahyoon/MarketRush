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
    
    var item: Item? = nil{
        
        didSet{
            if let product = item,
                let url = URL(string: product.item_image!){
                
                self.todayProductImage.af_setImage(withURL: url, completion: {
                    (image) in
                    self.todayProductImage.image = image.result.value
                })
            }
            
            //delete <> tag delete
            let string = item?.item_title?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
            
            self.todayProductName.text = string
            
        }
    }

    
}

