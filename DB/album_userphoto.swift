//
//  album.swift
//  DB
//
//  Created by 岩見建汰 on 2015/11/19.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class album_userphoto: UIViewController {
    
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var backbutton = UIButton()
    
    
    @IBOutlet weak var segmented: UISegmentedControl!
    //    @IBOutlet weak var navigationbar: UINavigationBar!
    //    @IBOutlet weak var collectionview: PagingCollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  let navBarImage = UIImage(named: "leaf.jpg") as UIImage?
        //        self.navigationbar.setBackgroundImage(navBarImage, forBarMetrics:. Default)
        //        self.collectionview.backgroundColor = UIColor(patternImage: UIImage(named: "haikei.png")!)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "haikei.png")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func segmentedchanged(sender: AnyObject) {
        switch sender.selectedSegmentIndex{
        case 0:
            appDelegate.pic_segmented = 0
            
        case 1:
            appDelegate.pic_segmented = 1
            let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier("album_defaultphoto")
            self.presentViewController( targetViewController, animated: false, completion: nil)
            self.segmented.selectedSegmentIndex = 0         //選択を戻す
        default:
            break
        }
    }
}
