//
//  TodayProductTableViewCell.swift
//  MarketRush
//
//  Created by Sarah Yoon on 2017. 2. 15..
//  Copyright © 2017년 Sarah Yoon. All rights reserved.
//

import UIKit

class TodayProductTableViewCell: UITableViewCell {

    @IBOutlet weak var todayProductCollectionView: UICollectionView!
    
    //오늘의 상품 테이블 뷰, section = 0
    var todayImage = ["strawberry.png","namul.png","chicken.png","juice.png","noodles.png","rice.png"]
    var todayTitle = ["친환경 하우스 딸기(설향)","친환경 봄나물 4종","[백년대계] 닭가슴살","콜드프레스 주스 6종","[마에스트리] 아티장 파스타 7종","게르마늄 쌀 2종"]
    var todayPrice = ["8500","2100","4200","7500","6900","9500"]
    var todayMall = ["당일수확, 당일배송되는 단단하고 상큼한 설향 딸기(1팩, 500g내외", "봄 내음 가득한 봄나물 달래, 냉이, 세발나물, 방풍나물","무항생제 친환경 닭고기 가슴살 (300g)","영양소 파괴없이 정성껏 짜낸 콜드프레스 주스","[컬리 단독수입]이탈리안 파스타의 자부심","인체에 유익한 게르마늄 성분과 쌀눈이 살아있는 맛있고 영양넘치는 게르마늄 쌀"] 
    

}

 //collectionview extension

extension TodayProductTableViewCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayProductCell", for: indexPath) as! TodayProductCollectionCell
       // cell.item = DataController.sharedInstance().items?[indexPath.row]
        cell.todayProductName.text = todayTitle[indexPath.row]
        cell.todayProductImage.image = UIImage(named: todayImage[indexPath.row])
        
        cell.todayProductImage.layer.borderWidth = 0.5
        cell.todayProductImage.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.todayProductName.layer.borderWidth = 0.5
        cell.todayProductName.layer.borderColor = UIColor.lightGray.cgColor

        
        return cell
    }
    
}

extension TodayProductTableViewCell: UICollectionViewDelegateFlowLayout {
    
    //getting the size of items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow:CGFloat = 3.0
        let hardCodedPadding: CGFloat = 5.0
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2*hardCodedPadding)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

