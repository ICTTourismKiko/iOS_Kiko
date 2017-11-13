//  diary.swift
//  キーコ紀行
//
//  Created by yosei yamazaki on 2017/11/06.
//  Copyright © 2017年 project03A. All rights reserved.
//

import UIKit

class diary: UIViewController{
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var navigationbar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigationbar.setBackgroundImage(navBarImage, for:. default)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "haikei.png")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backbutton(_ sender: AnyObject) {
        appDelegate.pic_segmented = 0
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }

}
