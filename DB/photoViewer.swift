//
//  photoViewer.swift
//  DB
//
//  Created by FUNAICT201311 on 2015/12/04.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class photoViewer: UIViewController , UIScrollViewDelegate{
    
    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var myScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //選択したIDを持ってくる処理
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let pic_id = appDelegate.P_ID
        
        //カードの画像を表示
        myImageView.image = PhotoController().NSSImage((DB().getCard(pic_id!).photo?.photoData)!)
        
        // スクロールビューの設定
        self.myScrollView.delegate = self
        self.myScrollView.minimumZoomScale = 1
        self.myScrollView.maximumZoomScale = 4
        self.myScrollView.scrollEnabled = true
        self.myScrollView.showsHorizontalScrollIndicator = true
        self.myScrollView.showsVerticalScrollIndicator = true
        
        let doubleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self
            , action:#selector(photoViewer.doubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        self.myImageView.userInteractionEnabled = true
        self.myImageView.addGestureRecognizer(doubleTapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // ピンチイン・ピンチアウト
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
       // print("pinch")
        return self.myImageView
    }
    // ダブルタップ
    func doubleTap(gesture: UITapGestureRecognizer) -> Void {
        
        //print(self.myScrollView.zoomScale)
        if ( self.myScrollView.zoomScale < self.myScrollView.maximumZoomScale ) {
            
            let newScale:CGFloat = self.myScrollView.zoomScale * 4
            let zoomRect:CGRect = self.zoomRectForScale(newScale, center: gesture.locationInView(gesture.view))
            self.myScrollView.zoomToRect(zoomRect, animated: true)
            
        } else {
            self.myScrollView.setZoomScale(1.0, animated: true)
        }
    }
    // 領域
    func zoomRectForScale(scale:CGFloat, center: CGPoint) -> CGRect{
        var zoomRect: CGRect = CGRect()
        zoomRect.size.height = self.myScrollView.frame.size.height / scale
        zoomRect.size.width = self.myScrollView.frame.size.width / scale
        
        zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
        zoomRect.origin.y = center.y - zoomRect.size.height / 2.0
        
        return zoomRect
    }
    
    @IBAction func backbutton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}