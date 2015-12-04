//
//  PrintPreview2Controller.swift
//  DB
//
//  Created by 池田俊輝 on 2015/11/30.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class PrintPreview2Controller: UIViewController {

    @IBOutlet weak var page2Image: UIImageView!
    
    let page1Image = UIImage(named: "omote.jpg")
    var print_NSData = NSData()
    let filename : NSString = "ki-ko"
    let arrayPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    var myData = NSData()
    
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        page2Image.image=appDelegate.view_pic

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func print(sender: AnyObject) {
        
        print_NSData = Image_NSData(appDelegate.view_pic)!
        
        let path = arrayPaths[0] as NSString
        let fullname : NSString = (filename as String) + ".pdf"
        let pdfFilename = (path as String) + "/"+(fullname as String)
        
        // PDFコンテキストを作成する
        UIGraphicsBeginPDFContextToFile(pdfFilename, CGRectZero, nil)
        
        // 1ページを開始する
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 1690, 1195), nil)
        // 1枚目画像を描画する
        let point1 = CGPointMake(0, 0)
        page1Image!.drawAtPoint(point1)
        
        // 2ページを開始する
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 1754, 1240), nil)
        // 2枚目画像を描画する
        let point2 = CGPointMake(0, 0)
        page2Image.image?.drawAtPoint(point2)
        
        //pdfの処理を終える
        UIGraphicsEndPDFContext()
        //pdfをnsDtataに変換
        myData = NSData(contentsOfFile: pdfFilename)!
        
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
    
    func Image_NSData(image:UIImage) -> NSData? {
        let data:NSData = UIImagePNGRepresentation(image)!
        return data
    }

    
}
