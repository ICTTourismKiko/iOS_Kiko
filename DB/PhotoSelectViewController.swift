//
//  PhotoSelectViewController.swift
//  DB
//
//  Created by 池田俊輝 on 2015/12/05.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class PhotoSelectViewController: UIViewController {

    @IBOutlet weak var navigation: UINavigationBar!
    @IBOutlet weak var backimage: UIImageView!
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var pic4: UIImageView!
    @IBOutlet weak var pic5: UIImageView!
    @IBOutlet weak var pic6: UIImageView!
    @IBOutlet weak var pic7: UIImageView!
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, forBarMetrics:. Default)
        
        backimage.image=UIImage(named:"haikei.jpg")
        
        NSTimer.scheduledTimerWithTimeInterval(0.5,target:self,selector:Selector("pic_show"),
            userInfo: nil, repeats: true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func photo1_select(sender: AnyObject) {
        appDelegate.picID=1
        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "cardlist2" )
        self.presentViewController( targetViewController, animated: true, completion: nil)
    }
    @IBAction func photo2_select(sender: AnyObject) {
        appDelegate.picID=2
        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "cardlist2" )
        self.presentViewController( targetViewController, animated: true, completion: nil)
    }
    @IBAction func photo3_select(sender: AnyObject) {
        appDelegate.picID=3
        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "cardlist2" )
        self.presentViewController( targetViewController, animated: true, completion: nil)
    }
    @IBAction func photo4_select(sender: AnyObject) {
        appDelegate.picID=4
        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "cardlist2" )
        self.presentViewController( targetViewController, animated: true, completion: nil)
    }
    @IBAction func photo5_select(sender: AnyObject) {
        appDelegate.picID=5
        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "cardlist2" )
        self.presentViewController( targetViewController, animated: true, completion: nil)
    }
    @IBAction func photo6_select(sender: AnyObject) {
        appDelegate.picID=6
        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "cardlist2" )
        self.presentViewController( targetViewController, animated: true, completion: nil)
    }
    @IBAction func photo7_select(sender: AnyObject) {
        appDelegate.picID=7
        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "cardlist2" )
        self.presentViewController( targetViewController, animated: true, completion: nil)
    }
    
    func pic_show(){
        
        if(appDelegate.cardID[1] == 0){
            pic1.image = UIImage(named: "noimage.jpg")
        }else{
            pic1.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[1]).photo?.photoData)!)
        }
        if(appDelegate.cardID[2] == 0){
            pic2.image = UIImage(named: "noimage.jpg")
        }else{
            pic2.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[2]).photo?.photoData)!)
        }
        if(appDelegate.cardID[3] == 0){
            pic3.image = UIImage(named: "noimage.jpg")
        }else{
            pic3.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[3]).photo?.photoData)!)
        }
        if(appDelegate.cardID[4] == 0){
            pic4.image = UIImage(named: "noimage.jpg")
        }else{
            pic4.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[4]).photo?.photoData)!)
        }
        if(appDelegate.cardID[5] == 0){
            pic5.image = UIImage(named: "noimage.jpg")
        }else{
            pic5.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[5]).photo?.photoData)!)
        }
        if(appDelegate.cardID[6] == 0){
            pic6.image = UIImage(named: "noimage.jpg")
        }else{
            pic6.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[6]).photo?.photoData)!)
        }
        if(appDelegate.cardID[7] == 0){
            pic7.image = UIImage(named: "noimage.jpg")
        }else{
            pic7.image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[7]).photo?.photoData)!)
        }
        
    }
    @IBAction func finish(sender: AnyObject) {
        if((appDelegate.cardID[1]==0)||(appDelegate.cardID[2]==0)||(appDelegate.cardID[3]==0)||(appDelegate.cardID[4]==0)||(appDelegate.cardID[5]==0)||(appDelegate.cardID[6]==0)||(appDelegate.cardID[7]==0)
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

    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
