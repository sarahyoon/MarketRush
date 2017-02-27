//
//  CategoryViewTableViewController.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 15..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RealmSwift
import MIBadgeButton_Swift

class CategoryViewTableViewController: UITableViewController {

    
    @IBOutlet var homeTableView: UITableView!
    @IBOutlet weak var cartBadge: MIBadgeButton!
    
    
    //Section
    var sections = ["오늘의 상품", "신선식품", "가공식품"]
    var categoryList = [["최신상품"],["야채", "과일", "곡류", "육류", "빵", "음료"],["유제품", "견과류", "면류/쌀", "소스류/오일류"]]
    
    //카테고리별 제목 배열
    var categoryTitle:[[String]]!
    //카테고리별 이미지 배열
    var categoryImage:[[String]]!
    
    
    var item: Item?
    var itemList = ListofItems()
    let realm = try? Realm()
    
   
    //for search controller managing database
    //var searchItems = DataController.sharedInstance().items
//    var resultSearchController = UISearchController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTotalItem()
        self.navigationItem.rightBarButtonItem?.didChangeValue(forKey: cartBadge.badgeString!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemList.items = realm?.objects(Item.self)
        
        categoryTitle = [[],["야채", "과일", "곡류", "육류", "빵", "음료"],["유제품", "견과류", "면류/쌀", "소스류/오일류"]]
        
        categoryImage = [[],["vege150.png","fruits150.png","cereal150.png","meat150.png","bread150.png","drink150.png"],["dairy150.png","nuts150.png","rice150.png","oil150.png"]]
        
        
        //add observer for product api calls
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveProductInfo(noti:)), name: DidReceiveProductInfo, object: nil)
        
        //오늘의 상품 api 호출 (식품)
        callProductApi(query: "신선식품+산지직송", start: 1, display: 20)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.done, target: self, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        
        //search controller
//        self.resultSearchController = UISearchController(searchResultsController: nil)
//        self.resultSearchController.searchResultsUpdater = self
//        
//        self.resultSearchController.dimsBackgroundDuringPresentation = false
//        self.resultSearchController.searchBar.sizeToFit()
//        
//        self.tableView.tableHeaderView = self.resultSearchController.searchBar
//        self.tableView.reloadData()
        
        //badge Counter
        
        
        
        

    }

    func updateTotalItem()
    {
        let myitem = self.itemList.items
        cartBadge.badgeString = (myitem?.count)?.description
        print("cartBagde: \(cartBadge.badgeString)")
        cartBadge.badgeEdgeInsets = UIEdgeInsetsMake(13, 5, 0, 0)
        
    }
    
    
    
    //remove observer
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: DidReceiveProductInfo, object: nil)
    }
    
    
    func didReceiveProductInfo(noti: Notification) {
        
        self.tableView.reloadSections(IndexSet([0]), with: UITableViewRowAnimation.automatic)
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
   
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    //섹션 헤더 색상/폰트 바꾸기
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.sectionHeaderHeight))
        headerView.backgroundColor = UIColor(red: 171/255, green: 216/255, blue: 167/255, alpha: 1.0)
        
        let label = UILabel(frame: CGRect(x: 5, y: 5, width: 100, height: 20))
        label.text = sections[section]
        label.textColor = UIColor.white
        headerView.addSubview(label)
    
        return headerView
    
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 15))
        footerView.backgroundColor = UIColor(red: 239/255, green: 240/255, blue: 241/255, alpha: 0.8)
        return footerView
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15.0
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //section별 row 갯수
        
        switch section
            {
            case 0:
                
                return categoryList[0].count
                
            case 1:
                
                return categoryList[1].count
                
            case 2:
                
                return categoryList[2].count
                
            default:
                NSLog("no count")
                return 1
            }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    //오늘의 상품
      if indexPath.section == 0
            
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodayProductCell", for: indexPath) as! TodayProductTableViewCell
            cell.todayProductCollectionView.reloadData()
    
            return cell
        }
            
        //신선식품 section
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
            cell.selectionStyle = .none
            cell.categoryTitle?.text = categoryTitle[1][indexPath.row]
            cell.categoryImage.image = UIImage(named: categoryImage[1][indexPath.row])

            return cell
            
        }
            
        //가공식품 section
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
            cell.selectionStyle = .none
            cell.categoryTitle?.text = categoryTitle[2][indexPath.row]
            cell.categoryImage.image = UIImage(named: categoryImage[2][indexPath.row])
            return cell
            
        }
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//       DataController.sharedInstance().items?.removeAll(keepingCapacity: false)
//        
//        let searchText = searchController.searchBar.text!
//        callProductApi(query: searchText, start: 1, display: 10)
//        self.tableView.reloadData()
//        
//    }
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
    {
        let cell  = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
        cell.backgroundColor = UIColor(red: 219/255, green: 236/255, blue: 144/255, alpha: 1.0)
        cell.categoryTitle.textColor = UIColor.white
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
        cell.backgroundColor = .clear
        cell.categoryTitle.textColor = UIColor.black
    }
    

    //tablecell별 높이 설정
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0
        {
            return 170
            
        }
            
        else{
            return 90
        }
        
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //해당카테고리로 이동하면서 관련 타이틀 갖고가기
        if(segue.identifier == "gotoSubCategory")
        {
            if let destination = segue.destination as? SubCategoryCollectionViewController{
                let path = tableView.indexPathForSelectedRow
                let section = tableView.indexPathForSelectedRow?.section
                
                destination.selectedCategory = categoryTitle[section!][(path?.row)!]}
        
        }
        
        if (segue.identifier == "gotoDetailfromToday"){
            if let todayProductImageCell = sender as? TodayProductCollectionCell, let detailProductView = segue.destination as? ProductDetailViewController{
                let product = todayProductImageCell.item
                detailProductView.item = product


            }
        }
    }

}

//extension CategoryViewTableViewController: UISearchResultsUpdating{
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchText: searchController.searchBar.text!)
//    }
//}
