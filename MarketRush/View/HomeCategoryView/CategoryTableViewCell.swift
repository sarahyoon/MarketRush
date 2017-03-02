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
    
    var item: Item? = nil{
        
        didSet{

            let string = item?.item_title?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
            self.categoryTitle.text = string
        }
    }
}
