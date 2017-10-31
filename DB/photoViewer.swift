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
    
    var pic_id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //選択したIDを持ってくる処理
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        pic_id = appDelegate.P_ID!
        
        //カードの画像を表示
        myImageView.image = PhotoController().NSSImage((DB().getCard(pic_id).photo?.photoData)!)
        
        // スクロールビューの設定
        self.myScrollView.delegate = self
        self.myScrollView.minimumZoomScale = 1
        self.myScrollView.maximumZoomScale = 4
        self.myScrollView.isScrollEnabled = true
        self.myScrollView.showsHorizontalScrollIndicator = true
        self.myScrollView.showsVerticalScrollIndicator = true
        
        let doubleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self
            , action:#selector(photoViewer.doubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        self.myImageView.isUserInteractionEnabled = true
        self.myImageView.addGestureRecognizer(doubleTapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //UIScrollBar表示時にスクロールバーをフラッシュ表示
        myScrollView.flashScrollIndicators()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // ピンチイン・ピンチアウト
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        // print("pinch")
        return self.myImageView
    }
    // ダブルタップ
    @objc func doubleTap(_ gesture: UITapGestureRecognizer) -> Void {
        
        //print(self.myScrollView.zoomScale)
        if ( self.myScrollView.zoomScale < self.myScrollView.maximumZoomScale ) {
            
            let newScale:CGFloat = self.myScrollView.zoomScale * 4
            let zoomRect:CGRect = self.zoomRectForScale(newScale, center: gesture.location(in: gesture.view))
            self.myScrollView.zoom(to: zoomRect, animated: true)
            
        } else {
            self.myScrollView.setZoomScale(1.0, animated: true)
        }
    }
    // 領域
    func zoomRectForScale(_ scale:CGFloat, center: CGPoint) -> CGRect{
        var zoomRect: CGRect = CGRect()
        zoomRect.size.height = self.myScrollView.frame.size.height / scale
        zoomRect.size.width = self.myScrollView.frame.size.width / scale
        
        zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
        zoomRect.origin.y = center.y - zoomRect.size.height / 2.0
        
        return zoomRect
    }
    
    @IBAction func backbutton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //写真を元に戻す
    @IBAction func changePhoto(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "", message: "本当に元に戻しますか？", preferredStyle: .alert)
        let otherAction = UIAlertAction(title: "OK", style: .default) {
            action in let photo = DB().getDefaultPhoto(self.pic_id)
            self.myImageView.image = PhotoController().NSSImage(photo.photoData!)
            DB().linkToCardData(photo)
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .default) {
            action in print("CANCEL")
        }
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
