//
//  PrintPreviewController.swift
//  DB
//
//  Created by 池田俊輝 on 2015/11/26.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class PrintPreviewController: UIViewController {
    
    var print_NSData = Data()

    @IBOutlet weak var front: UIImageView!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var navigation: UINavigationBar!
  //  @IBOutlet weak var scroll: UIScrollView!
    let image = UIImage(named: "omote.jpg")
    let filename : String = "ki-ko"
    //let arrayPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    var arrayPaths = NSObject()
    
    var myData = Data()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, for:. default)
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
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
        
        //let path = arrayPaths[0] as NSString
        

        let path = NSTemporaryDirectory();
        let fullname : NSString = (filename as String) + ".pdf" as NSString
        let pdfFilename = (path as String) + "/"+(fullname as String)
        arrayPaths = pdfFilename as NSObject
        
        // PDFコンテキストを作成する
        UIGraphicsBeginPDFContextToFile(pdfFilename, CGRect.zero, nil)
        
        // 1ページを開始する
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 1690, height: 1195), nil)
        // 1枚目画像を描画する
        let point1 = CGPoint(x: 0, y: 0)
        front.image?.draw(at: point1)
        
        // 2ページを開始する
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 1754, height: 1240), nil)
        // 2枚目画像を描画する
        let point2 = CGPoint(x: 0, y: 0)
        back.image?.draw(at: point2)
        
        //pdfの処理を終える
        UIGraphicsEndPDFContext()
        //pdfをnsDtataに変換
        myData = try! Data(contentsOf: URL(fileURLWithPath: pdfFilename))

    }
    
    //画像をNSDataに変換
    func Image_NSData(_ image:UIImage) -> Data? {
        let data:Data = UIImagePNGRepresentation(image)!
        return data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func print(_ sender: AnyObject) {
        if(UIPrintInteractionController.canPrint(myData)){
            let printController = UIPrintInteractionController.shared
            let printInfo = UIPrintInfo(dictionary:nil)
            //カラー印刷
            printInfo.outputType = UIPrintInfoOutputType.general
            printInfo.jobName = "print Job"
            // 両面印刷/片面印刷 None, LongEdge, ShortEdge の３択
            printInfo.duplex = UIPrintInfoDuplex.longEdge
            // 印刷用紙の向き - 縦Portrait 横Landscape の２択
            printInfo.orientation = UIPrintInfoOrientation.landscape
            printController.printInfo = printInfo
            printController.showsPageRange = true
            printController.printingItem = myData
            printController.present(animated: true, completionHandler: nil)
        }

    }
    
    @IBAction func back(_ sender: AnyObject) {
        let manager = FileManager()
        do {
            try manager.removeItem(atPath: arrayPaths as! String)
        } catch let error as NSError {
            print(error.localizedDescription as AnyObject)
        }
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
