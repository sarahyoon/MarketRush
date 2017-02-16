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
    

}

 //collectionview extension
// 오늘의 상품 테이블 뷰셀에 수평방향 콜렉션 뷰 담기

extension TodayProductTableViewCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayProductCell", for: indexPath) as! TodayProductCollectionCell
        cell.product = ProductData.sharedInstance.mrProducts?[indexPath.row]
        
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

