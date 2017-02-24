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
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
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
        
        self.plusButton.layer.cornerRadius = 4.0
        self.plusButton.backgroundColor = UIColor(red: 55/255, green: 142/255, blue: 109/255, alpha: 1.0)
        self.plusButton.tintColor = UIColor.white
        
        self.minusButton.layer.cornerRadius = 4.0
        self.minusButton.backgroundColor = UIColor(red: 55/255, green: 142/255, blue: 109/255, alpha: 1.0)
        self.minusButton.tintColor = UIColor.white
        
        
    }
    
    

}
