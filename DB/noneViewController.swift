//
//  noneViewController.swift
//  DB
//
//  Created by 池田俊輝 on 2015/11/27.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class noneViewController: UIViewController {
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(appDelegate.picID<=3){
            NSTimer.scheduledTimerWithTimeInterval(0.01,target:self,selector:Selector("target1"),
                userInfo: nil, repeats: false);
        }else{
            NSTimer.scheduledTimerWithTimeInterval(0.01,target:self,selector:Selector("target2"),
                userInfo: nil, repeats: false);
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func target1(){
        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "target1" )
        self.presentViewController( targetViewController, animated: true, completion: nil)
    }
    func target2(){
        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "target2" )
        self.presentViewController( targetViewController, animated: true, completion: nil)
    }
    
}
