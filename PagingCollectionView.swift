//
//  PagingCollectionView.swift
//  DB
//
//  Created by 岩見建汰 on 2015/11/21.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class PagingCollectionView: UIView {
    
    // MARK: - Properties
    internal let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    internal var contentSize: CGSize {
        return CGSizeMake(CGRectGetWidth(UIScreen.mainScreen().bounds) - 0, CGRectGetHeight(UIScreen.mainScreen().bounds) - 0)
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
    
    private func initView() {
        
        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "haikei.png")!)
        self.collectionView.frame = CGRectMake(0.0, 0.0, self.contentSize.width, self.contentSize.height)
        print(self.contentSize.width)
        print(self.contentSize.height)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.clipsToBounds = false
        self.collectionView.pagingEnabled = true
        self.collectionView.alwaysBounceHorizontal = true
        // For Cell
        self.collectionView.registerNib(UINib(nibName: "PagingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PagingCollectionViewCell")
        
        // Change layout
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .Horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        self.collectionView.setCollectionViewLayout(layout, animated: false)
        
        self.addSubview(self.collectionView)
    }
    
    // MARK: - Override Methods
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if !CGRectContainsPoint(self.collectionView.frame, point) {
            return self.collectionView
        }
        return super.hitTest(point, withEvent: event)
    }
    
}

// MARK: - UICollectionView DataSource
extension PagingCollectionView: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DB().getUpdatedCardIDArray().count       //撮った写真の数だけ表示
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PagingCollectionViewCell", forIndexPath: indexPath) as! PagingCollectionViewCell
        
        var UpdateCardIDArray = DB().getUpdatedCardIDArray()        //updateがtrueになっているID配列をDBからコピー
        
        let NSphotodata = DB().getCard(UpdateCardIDArray[indexPath.row]).photo?.photoData   //ID配列でDBからレコード内の写真データ(NSdata)を取得
        cell.photo.image = PhotoController().NSSImage(NSphotodata!)  //写真データ(NSdata)をimageに変換
        
        let titletext = DB().getCard(UpdateCardIDArray[indexPath.row]).cardText?.title
        
        let introtext = (DB().getCard(UpdateCardIDArray[indexPath.row]).cardText?.text)!
        
        cell.TitleLabel.text = titletext
        cell.introLabel.text = introtext
        
        return cell
    }
    
}

// MARK: - UICollectionView Delegate
extension PagingCollectionView: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return self.contentSize
    }
    
}
