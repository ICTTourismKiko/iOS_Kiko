//
//  PagingCollectionView.swift
//  DB
//
//  Created by 岩見建汰 on 2015/11/21.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit
//テストコメント
class PagingCollectionView: UIView {
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var credit = UILabel()
    
    // MARK: - Properties
    internal let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    internal var contentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 0, height: UIScreen.main.bounds.height - 0)
    }
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    fileprivate func initView() {
        
        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "haikei.png")!)
        self.collectionView.frame = CGRect(x: 0.0, y: 0.0, width: self.contentSize.width, height: self.contentSize.height)
        self.collectionView.delegate = self as? UICollectionViewDelegate
        self.collectionView.dataSource = self as? UICollectionViewDataSource
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.clipsToBounds = false
        self.collectionView.isPagingEnabled = true
        self.collectionView.alwaysBounceHorizontal = true
        //        self.collectionView.scrollEnabled = false
        // For Cell
        self.collectionView.register(UINib(nibName: "PagingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PagingCollectionViewCell")
        
        
        // Change layout
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        self.collectionView.setCollectionViewLayout(layout, animated: false)
        
        self.addSubview(self.collectionView)
    }
    
    // MARK: - Override Methods
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.collectionView.frame.contains(point) {
            return self.collectionView
        }
        return super.hitTest(point, with: event)
    }
}



     // MARK: - UICollectionView Delegate
     extension PagingCollectionView: UICollectionViewDelegate {
     
        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagingCollectionViewCell", for: indexPath as IndexPath) as! PagingCollectionViewCell
        return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
     return self.contentSize
     }
        
}


