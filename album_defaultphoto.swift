//
//  album_defaultphoto.swift
//  DB
//
//  Created by 岩見建汰 on 2015/11/28.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class album_defaultphoto: UIViewController {
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var navigationbar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigationbar.setBackgroundImage(navBarImage, forBarMetrics:. Default)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "haikei.png")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentedchanged(sender: AnyObject) {
        switch sender.selectedSegmentIndex{
        case 0: //撮影写真
            appDelegate.pic_segmented = 0
            self.dismissViewControllerAnimated(false, completion: nil)
        case 1: //サンプル写真
            appDelegate.pic_segmented = 1
        default:
            break
        }
    }
    @IBAction func backbutton(sender: AnyObject) {
        appDelegate.pic_segmented = 0
        self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
