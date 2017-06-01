//
//  information.swift
//  DB
//
//  Created by 山川拓也 on 2016/07/11.
//  Copyright © 2016年 project03A. All rights reserved.
//

import UIKit

class information: UIViewController {
    
    @IBOutlet weak var uitext: UITextView!
    @IBOutlet weak var navigation: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, for:. default)
        
        
        self.uitext.isEditable = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //UIScrollBar表示時にスクロールバーをフラッシュ表示
        uitext.flashScrollIndicators()
    }
    
    @IBAction func backbutton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
