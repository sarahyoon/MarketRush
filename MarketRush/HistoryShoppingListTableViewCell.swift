//
//  HistoryShoppingListTableViewCell.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 20..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit

class HistoryShoppingListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listSavedDate: UILabel!
    @IBOutlet weak var numOfItems: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
