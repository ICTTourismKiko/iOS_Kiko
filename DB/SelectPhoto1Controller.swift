//
//  SelectPhoto1Controller.swift
//  DB
//
//  Created by 池田俊輝 on 2015/11/26.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class SelectPhoto1Controller: UIViewController {
    
    @IBOutlet weak var photo1: UIImageView!
    @IBOutlet weak var photo2: UIImageView!
    @IBOutlet weak var photo3: UIImageView!
    @IBOutlet weak var navigation: UINavigationBar!
    @IBOutlet weak var barItem1: UIBarButtonItem!
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, forBarMetrics:. Default)
        navigation.tintColor = UIColor.whiteColor()
        
        
        NSTimer.scheduledTimerWithTimeInterval(0.01,target:self,selector:Selector("pic_show"),
            userInfo: nil, repeats: false);

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func photo1_select(sender: AnyObject) {
        appDelegate.picID=1
    }
    @IBAction func photo2_select(sender: AnyObject) {
        appDelegate.picID=2
    }
    @IBAction func photo3_select(sender: AnyObject) {
        appDelegate.picID=3
    }
    func pic_show(){
        
        if(appDelegate.cardID[1] == 0){
            photo1.image = UIImage(named: "noimage.jpg")
        }else{
            photo1.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[1]).photo?.photoData)!)
        }
        
        if(appDelegate.cardID[2] == 0){
            photo2.image = UIImage(named: "noimage.jpg")
        }else{
            photo2.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[2]).photo?.photoData)!)
        }
        if(appDelegate.cardID[3] == 0){
            photo3.image = UIImage(named: "noimage.jpg")
        }else{
            photo3.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[3]).photo?.photoData)!)
        }
        
    }
}
