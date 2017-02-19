//
//  DetailShoppingListTableViewCell.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 17..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit


protocol DetailShoppingListTableViewCellDelegate {
    func detailShoppingListTableViewCellDidChangeNumber(cell: DetailShoppingListTableViewCell)
}

class DetailShoppingListTableViewCell: UITableViewCell {

    var delegate: DetailShoppingListTableViewCellDelegate?
    var item: Item!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var numOfItemInput: UITextField!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBAction func clickPlusButton(sender: UIButton) {
        var number = 0
        var price = 0
        
        if let num = Int(self.numOfItemInput.text!) {
            number = num + 1
            
            
            
        }
        
        self.numOfItemInput.text = "\(number)"
        
        
        self.delegate?.detailShoppingListTableViewCellDidChangeNumber(cell: self)
    }
    
    @IBAction func clickMinusButton(sender: UIButton) {
        var number = 0
        
        if let num = Int(self.numOfItemInput.text!) {
            number = num - 1
        }
        
        if number < 1 {
            return
        }
        
        self.numOfItemInput.text = "\(number)"
        
        self.delegate?.detailShoppingListTableViewCellDidChangeNumber(cell: self)
    }
    
    
    //tableviewcell에다가 버튼 액션을 줘서 테이블뷰에서 컨트롤? 
    
    
//    var product: Product? {
//        didSet {
//
//            if let product = product, let url = URL(string: product.image!){
//                
//                self.productImage.af_setImage(withURL: url, completion: {
//                    (image) in
//                    self.productImage.image = image.result.value
//                })
//            }
//            
//
//        }
//    }

}
