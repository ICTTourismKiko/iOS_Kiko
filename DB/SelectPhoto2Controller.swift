//
//  SelectPhoto2Controller.swift
//  DB
//
//  Created by 池田俊輝 on 2015/11/26.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class SelectPhoto2Controller: UIViewController {
    
    @IBOutlet weak var photo4: UIImageView!
    @IBOutlet weak var photo5: UIImageView!
    @IBOutlet weak var photo6: UIImageView!
    @IBOutlet weak var photo7: UIImageView!
    @IBOutlet weak var photo8: UIImageView!
    @IBOutlet weak var navigation: UINavigationBar!
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, forBarMetrics:. Default)
        
        NSTimer.scheduledTimerWithTimeInterval(0.01,target:self,selector:Selector("pic_show"),
            userInfo: nil, repeats: false);

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func pic4_select(sender: AnyObject) {
        appDelegate.picID=4
    }
    @IBAction func pic5_select(sender: AnyObject) {
        appDelegate.picID=5
    }
    @IBAction func pic6_select(sender: AnyObject) {
        appDelegate.picID=6
    }
    @IBAction func pic7_select(sender: AnyObject) {
        appDelegate.picID=7
    }
    @IBAction func pic8_select(sender: AnyObject) {
        appDelegate.picID=8
    }
    
    func pic_show(){
        
        if(appDelegate.cardID[4] == 0){
            photo4.image = UIImage(named: "noimage.jpg")
        }else{
            photo4.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[4]).photo?.photoData)!)
        }
        
        if(appDelegate.cardID[5] == 0){
            photo5.image = UIImage(named: "noimage.jpg")
        }else{
            photo5.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[5]).photo?.photoData)!)
        }
        if(appDelegate.cardID[6] == 0){
            photo6.image = UIImage(named: "noimage.jpg")
        }else{
            photo6.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[6]).photo?.photoData)!)
        }
        if(appDelegate.cardID[7] == 0){
            photo7.image = UIImage(named: "noimage.jpg")
        }else{
            photo7.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[7]).photo?.photoData)!)
        }
        if(appDelegate.cardID[8] == 0){
            photo8.image = UIImage(named: "noimage.jpg")
        }else{
            photo8.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[8]).photo?.photoData)!)
        }
        
    }
    
    @IBAction func finish(sender: AnyObject) {
        if((appDelegate.cardID[1]==0)||(appDelegate.cardID[2]==0)||(appDelegate.cardID[3]==0)||(appDelegate.cardID[4]==0)||(appDelegate.cardID[5]==0)||(appDelegate.cardID[6]==0)||(appDelegate.cardID[7]==0)||(appDelegate.cardID[8]==0)
            ){
                let myAlert: UIAlertController = UIAlertController(title: "エラー", message: "画像を全て選んでください", preferredStyle: .Alert)
                // OKのアクションを作成する.
                let myOkAction = UIAlertAction(title: "OK", style: .Default) { action in }
                // OKのActionを追加する.
                myAlert.addAction(myOkAction)
                // UIAlertを発動する.
                presentViewController(myAlert, animated: true, completion: nil)
        }else{
            let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "sample" )
            self.presentViewController( targetViewController, animated: true, completion: nil)
        }
    }
}
