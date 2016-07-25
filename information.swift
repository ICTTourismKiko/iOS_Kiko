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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    self.uitext.editable = false
    
    }
    
    @IBAction func backbutton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
