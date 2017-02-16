//
//  ProductDetailViewController.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 16..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var product: Product!
    var list = ["상품이름", "가격", "쇼핑몰이름"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //4
        return self.list.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailImageCell") as! DetailImageTableViewCell
            if let url = NSURL(string:product.image!){
                cell.productimage.af_setImage(withURL: url as URL)
            }
            return cell
        }
        else{ // row == 1
            
            //let row = self.list[indexPath.row] //2번째 row부터
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailDescriptionCell") as! DetailDescriptionTableViewCell
            
            cell.productName.text = product.title
            cell.price.text = "가격"
            cell.productPrice.text = product.price
            cell.mallName.text = "쇼핑몰"
            cell.productMall.text = product.mallName

            return cell
            
        }
    }
    


    @IBAction func itemsToList(_ sender: Any) {
        
        let alertController : UIAlertController = UIAlertController(title: "", message: "장바구니에 담겼습니다!\r\n장바구니로 이동하시겠습니까?", preferredStyle: .alert)
        let action_cancel = UIAlertAction.init(title: "Cancel", style: .cancel) { (UIAlertAction) -> Void in
            
        }
        alertController.addAction(action_cancel)
        
        let action_add = UIAlertAction.init(title: "네", style: .default)
        { (UIAlertAction) -> Void in
            
            let storyBoard = UIStoryboard(name:"Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailShoppingListViewController") as! DetailShoppingListViewController
            self.present(nextViewController, animated:true, completion:nil)
            
//            let todoItem = TodoItem() //initiate realm
//            todoItem.detail = textField_todo.text! //set details
//            todoItem.status = 0
//            
//            //save realm persistent
//            try! self.realm.write({
//                self.realm.add(todoItem)
//                self.tableView.insertRows(at: [IndexPath.init(row: self.todoList.count-1, section: 0)], with: .automatic)
//            })
            
        }
        alertController.addAction(action_add)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
