//
//  DetailShoppingListTableViewCell.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 17..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit
import RealmSwift


protocol DetailShoppingListTableViewCellDelegate {
    func detailShoppingListTableViewCellDidChangeNumber(cell: DetailShoppingListTableViewCell)
}

class DetailShoppingListTableViewCell: UITableViewCell, UITextFieldDelegate {

    var delegate: DetailShoppingListTableViewCellDelegate?
    var item: Item!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var numOfItemInput: UITextField!
    
    @IBOutlet weak var productPrice: UILabel!
    
    var priceForOne: Int = 0
    var number = 0
    var price = 0
    

    
    @IBAction func clickPlusButton(sender: UIButton) {

        if let num = Int(self.numOfItemInput.text!) {
            number = num + 1
            
            price = priceForOne * number
            
//            price = Int(productPrice.text!)!
//            price = number*price
            
        }
        
        self.numOfItemInput.text = "\(number)"
        self.productPrice.text = "\(price)"
        
        
        
        self.delegate?.detailShoppingListTableViewCellDidChangeNumber(cell: self)
    }
    
    @IBAction func clickMinusButton(sender: UIButton) {
//        var number = 0
//        var price = 0
        
        if let num = Int(self.numOfItemInput.text!) {
            number = num - 1
            
            price = priceForOne * number
            

        }
        
        if number < 1 {
            return
        }
        
        self.numOfItemInput.text = "\(number)"
        self.productPrice.text = "\(price)"
        
        self.delegate?.detailShoppingListTableViewCellDidChangeNumber(cell: self)
    }
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.productImage.layer.borderWidth = 0.6
        self.productImage.layer.borderColor = UIColor.lightGray.cgColor
        
        
        
        
    }
    
    

}
