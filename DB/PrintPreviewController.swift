//
//  PrintPreviewController.swift
//  DB
//
//  Created by 池田俊輝 on 2015/11/26.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class PrintPreviewController: UIViewController {
    
    var print_NSData = NSData()

    @IBOutlet weak var front: UIImageView!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var navigation: UINavigationBar!
  //  @IBOutlet weak var scroll: UIScrollView!
    let image = UIImage(named: "omote.jpg")
    let filename : NSString = "ki-ko"
    let arrayPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    var myData = NSData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, forBarMetrics:. Default)
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        print_NSData = Image_NSData(appDelegate.view_pic)!
        
        
//        // スクロールビューの設定
//        self.scroll.delegate = self
//        self.scroll.minimumZoomScale = 1
//        self.scroll.maximumZoomScale = 4
//        self.scroll.scrollEnabled = true
//        self.scroll.showsHorizontalScrollIndicator = true
//        self.scroll.showsVerticalScrollIndicator = true
//        
//        
//        // ピンチイン・ピンチアウト
//        func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
//            // print("pinch")
//            return self
//        }
        
        //裏、表のプレビュー表示
        back.image=appDelegate.view_pic
        front.image=image
        
        let path = arrayPaths[0] as NSString
        let fullname : NSString = (filename as String) + ".pdf"
        let pdfFilename = (path as String) + "/"+(fullname as String)
        
        // PDFコンテキストを作成する
        UIGraphicsBeginPDFContextToFile(pdfFilename, CGRectZero, nil)
        
        // 1ページを開始する
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 1690, 1195), nil)
        // 1枚目画像を描画する
        let point1 = CGPointMake(0, 0)
        front.image?.drawAtPoint(point1)
        
        // 2ページを開始する
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 1754, 1240), nil)
        // 2枚目画像を描画する
        let point2 = CGPointMake(0, 0)
        back.image?.drawAtPoint(point2)
        
        //pdfの処理を終える
        UIGraphicsEndPDFContext()
        //pdfをnsDtataに変換
        myData = NSData(contentsOfFile: pdfFilename)!

    }
    
    //画像をNSDataに変換
    func Image_NSData(image:UIImage) -> NSData? {
        let data:NSData = UIImagePNGRepresentation(image)!
        return data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func print(sender: AnyObject) {
        if(UIPrintInteractionController.canPrintData(myData)){
            let printController = UIPrintInteractionController.sharedPrintController()
            let printInfo = UIPrintInfo(dictionary:nil)
            //カラー印刷
            printInfo.outputType = UIPrintInfoOutputType.General
            printInfo.jobName = "print Job"
            // 両面印刷/片面印刷 None, LongEdge, ShortEdge の３択
            printInfo.duplex = UIPrintInfoDuplex.LongEdge
            // 印刷用紙の向き - 縦Portrait 横Landscape の２択
            printInfo.orientation = UIPrintInfoOrientation.Landscape
            printController.printInfo = printInfo
            printController.showsPageRange = true
            printController.printingItem = myData
            printController.presentAnimated(true, completionHandler: nil)
        }

    }
    
    @IBAction func back(sender: AnyObject) {
        self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
