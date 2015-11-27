//
//  album.swift
//  DB
//
//  Created by 岩見建汰 on 2015/11/19.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class album: UIViewController {
    
    var backbutton = UIButton()
    
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
    
    @IBAction func BackButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
}
