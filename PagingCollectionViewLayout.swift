//
//  PagingCollectionViewLayout.swift
//  DB
//
//  Created by 岩見建汰 on 2015/11/21.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class PagingCollectionViewLayout: UICollectionViewFlowLayout {
    
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // 左右１ピクセルをはみ出させることで、普通は描画されない横のスライドも描画させる
        // このことで、カードリストのような左右のcellがframe外で表示されるようになる
        // ただし、collectionView本体のclipsToBoundsがfalseになっていないといけない
        let attributes = super.layoutAttributesForElementsInRect(rect)
        for attribute in attributes! as [UICollectionViewLayoutAttributes] {
            var rect = attribute.bounds
            rect.size.width += 1
            attribute.bounds = rect
        }
        
        return attributes
    }
    
}
