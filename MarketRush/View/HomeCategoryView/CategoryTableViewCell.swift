//
//  CategoryTableViewCell.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 15..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var categoryTitle: UILabel!

    @IBOutlet weak var categoryImage: UIImageView!
    
    //오늘의 상품 데이터주소 불러와 담기
    var item: Item? = nil{
        
        //product 값이 변경된 직후에 호출
        didSet{

            let string = item?.item_title?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
            self.categoryTitle.text = string
        }
    }
}
