//
//  CreateViewController.swift
//  DB
//
//  Created by 池田俊輝 on 2015/12/03.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    @IBOutlet var background_view: UIView!
    
    @IBOutlet weak var backimage: UIImageView!
    
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var pic4: UIImageView!
    @IBOutlet weak var pic5: UIImageView!
    @IBOutlet weak var pic6: UIImageView!
    @IBOutlet weak var pic7: UIImageView!
    
    @IBOutlet weak var textback1: UIImageView!
    @IBOutlet weak var textback2: UIImageView!
    @IBOutlet weak var textback3: UIImageView!
    @IBOutlet weak var textback4: UIImageView!
    @IBOutlet weak var textback5: UIImageView!
    @IBOutlet weak var textback6: UIImageView!
    @IBOutlet weak var textback7: UIImageView!
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var title4: UILabel!
    @IBOutlet weak var title5: UILabel!
    @IBOutlet weak var title6: UILabel!
    @IBOutlet weak var title7: UILabel!
    
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text4: UILabel!
    @IBOutlet weak var text5: UILabel!
    @IBOutlet weak var text7: UILabel!
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        backimage.image = UIImage(named: "haikei.png")
        
        textback1.image = UIImage(named: "b300.png")
        textback2.image = UIImage(named: "b300.png")
        textback3.image = UIImage(named: "b300.png")
        textback4.image = UIImage(named: "b300.png")
        textback5.image = UIImage(named: "b300.png")
        textback6.image = UIImage(named: "b300.png")
        textback7.image = UIImage(named: "b300.png")
        
        title1.text=DB().getCard(appDelegate.cardID[1]).cardText?.title
        title2.text=DB().getCard(appDelegate.cardID[2]).cardText?.title
        title3.text=DB().getCard(appDelegate.cardID[3]).cardText?.title
        title4.text=DB().getCard(appDelegate.cardID[4]).cardText?.title
        title5.text=DB().getCard(appDelegate.cardID[5]).cardText?.title
        title6.text=DB().getCard(appDelegate.cardID[6]).cardText?.title
        title7.text=DB().getCard(appDelegate.cardID[7]).cardText?.title
        
        text1.text=DB().getCard(appDelegate.cardID[1]).cardText?.text
        text4.text=DB().getCard(appDelegate.cardID[4]).cardText?.text
        text5.text=DB().getCard(appDelegate.cardID[5]).cardText?.text
        text7.text=DB().getCard(appDelegate.cardID[7]).cardText?.text
        
        
        pic1.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[1]).photo?.photoData)!)
        pic2.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[2]).photo?.photoData)!)
        pic3.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[3]).photo?.photoData)!)
        pic4.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[4]).photo?.photoData)!)
        pic5.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[5]).photo?.photoData)!)
        pic6.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[6]).photo?.photoData)!)
        pic7.image=PhotoController().NSSImage((DB().getCard(appDelegate.cardID[7]).photo?.photoData)!)
        
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
