//
//  PhotoSelectViewController.swift
//  DB
//
//  Created by 池田俊輝 on 2015/12/05.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class PhotoSelectViewController: UIViewController {
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var navigation: UINavigationBar!
    @IBOutlet weak var backimage: UIImageView!
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var pic4: UIImageView!
    @IBOutlet weak var pic5: UIImageView!
    @IBOutlet weak var pic6: UIImageView!
    @IBOutlet weak var pic7: UIImageView!
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var imageArray: Array<UIImageView> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, for:. default)
        
        backimage.image=UIImage(named:"haikei.jpg")
        
        /* pic達を配列に格納しておく */
        imageArray.append(pic1)
        imageArray.append(pic2)
        imageArray.append(pic3)
        imageArray.append(pic4)
        imageArray.append(pic5)
        imageArray.append(pic6)
        imageArray.append(pic7)
        
        //        NSTimer.scheduledTimerWithTimeInterval(0.5,target:self,selector:Selector("pic_show"),
        //            userInfo: nil, repeats: true);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //UIScrollBar表示時にスクロールバーをフラッシュ表示
        scroll.flashScrollIndicators()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.pic_show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func photo1_select(_ sender: AnyObject) {
        appDelegate.picID=1
        let targetViewController = self.storyboard!.instantiateViewController( withIdentifier: "cardlist2" )
        self.present( targetViewController, animated: true, completion: nil)
    }
    @IBAction func photo2_select(_ sender: AnyObject) {
        appDelegate.picID=2
        let targetViewController = self.storyboard!.instantiateViewController( withIdentifier: "cardlist2" )
        self.present( targetViewController, animated: true, completion: nil)
    }
    @IBAction func photo3_select(_ sender: AnyObject) {
        appDelegate.picID=3
        let targetViewController = self.storyboard!.instantiateViewController( withIdentifier: "cardlist2" )
        self.present( targetViewController, animated: true, completion: nil)
    }
    @IBAction func photo4_select(_ sender: AnyObject) {
        appDelegate.picID=4
        let targetViewController = self.storyboard!.instantiateViewController( withIdentifier: "cardlist2" )
        self.present( targetViewController, animated: true, completion: nil)
    }
    @IBAction func photo5_select(_ sender: AnyObject) {
        appDelegate.picID=5
        let targetViewController = self.storyboard!.instantiateViewController( withIdentifier: "cardlist2" )
        self.present( targetViewController, animated: true, completion: nil)
    }
    @IBAction func photo6_select(_ sender: AnyObject) {
        appDelegate.picID=6
        let targetViewController = self.storyboard!.instantiateViewController( withIdentifier: "cardlist2" )
        self.present( targetViewController, animated: true, completion: nil)
    }
    @IBAction func photo7_select(_ sender: AnyObject) {
        appDelegate.picID=7
        let targetViewController = self.storyboard!.instantiateViewController( withIdentifier: "cardlist2" )
        self.present( targetViewController, animated: true, completion: nil)
    }
    
    func pic_show(){
        for i in 0 ..< 7 {
            if(appDelegate.cardID[i+1] == 0){
                imageArray[i].image = UIImage(named: "noimage.png")
            }else{
                imageArray[i].image = PhotoController().NSSImage((DB().getCard(appDelegate.cardID[i+1]).photo?.photoData)!)
            }
        }
    }
    @IBAction func finish(_ sender: AnyObject) {
        if((appDelegate.cardID[1]==0)||(appDelegate.cardID[2]==0)||(appDelegate.cardID[3]==0)||(appDelegate.cardID[4]==0)||(appDelegate.cardID[5]==0)||(appDelegate.cardID[6]==0)||(appDelegate.cardID[7]==0)
            ){
            let myAlert: UIAlertController = UIAlertController(title: "エラー", message: "画像を全て選んでください", preferredStyle: .alert)
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "OK", style: .default) { action in }
            // OKのActionを追加する.
            myAlert.addAction(myOkAction)
            // UIAlertを発動する.
            present(myAlert, animated: true, completion: nil)
        }else{
            let targetViewController = storyboard!.instantiateViewController(withIdentifier: "sample" )
            self.present(targetViewController, animated: true, completion: nil)
            //            let storyboard: UIStoryboard = UIStoryboard(name: "test", bundle: nil)
            //            let nextView = storyboard.instantiateInitialViewController()
            //            present(nextView!, animated: true, completion: nil)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
