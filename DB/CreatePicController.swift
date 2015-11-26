//
//  CreatePicController.swift
//  DB
//
//  Created by 池田俊輝 on 2015/11/27.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class CreatePicController: UIViewController {

    @IBOutlet var background_view: UIView!
    @IBOutlet weak var backimage: UIImageView!
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var pic4: UIImageView!
    @IBOutlet weak var pic5: UIImageView!
    @IBOutlet weak var pic6: UIImageView!
    @IBOutlet weak var pic7: UIImageView!
    @IBOutlet weak var pic8: UIImageView!
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backimage.image = UIImage(named: "haikei.png")
        
        pic1.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[1]).photo?.photoData)!)
        pic2.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[2]).photo?.photoData)!)
        pic3.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[3]).photo?.photoData)!)
        pic4.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[4]).photo?.photoData)!)
        pic5.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[5]).photo?.photoData)!)
        pic6.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[6]).photo?.photoData)!)
        pic7.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[7]).photo?.photoData)!)
        pic8.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[8]).photo?.photoData)!)
        
        appDelegate.view_pic = getUIImageFromUIView(background_view)
        
        NSTimer.scheduledTimerWithTimeInterval(0.01,target:self,selector:Selector("next"),
            userInfo: nil, repeats: false);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getUIImageFromUIView(myUIView:UIView) ->UIImage{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1754, 1240), false, 0);//必要なサイズ確保
        let context:CGContextRef = UIGraphicsGetCurrentContext()!;
        CGContextTranslateCTM(context, 0, 0);
        myUIView.layer.renderInContext(context);
        let renderedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return renderedImage;
    }
    func next() {
        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "print" )
        self.presentViewController( targetViewController, animated: true, completion: nil)
    }

}
