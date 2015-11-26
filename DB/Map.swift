//
//  Map.swift
//  DB
//
//  Created by 岩見建汰 on 2015/10/22.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit
import MapKit

class Map: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{
    
    @IBOutlet weak var CardMap: MKMapView!
    @IBOutlet weak var camera2View: UIImageView!
    @IBOutlet weak var navigation: UINavigationBar!
    @IBOutlet weak var ChangeTextButton: UIButton!
    
    var myLocationManager: CLLocationManager!
    
    class Pin : MKPointAnnotation{
        var ID = 0
        var text = ""
        var info = ""
        var photo = NSData()
        var categoryID = 0
        var x: Double = 0.0
        var y: Double = 0.0
        var imageName = ""
    }
    
    var PinArray: Array<Pin> = []
    var PinAddress = 0
    
    var CardSyousai = UILabel()
    var CardPoemu = UILabel()
    var CardTopSyousai = UILabel()
    var CardTopPoemu = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChangeTextButton.setImage(UIImage(named: "next.png"), forState: .Normal)
        
        let navBarImage = UIImage(named: "leaf.jpg") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, forBarMetrics:. Default)
        
        //選択したIDを持ってくる処理
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let pic_id = appDelegate.P_ID
        
        
        //ラベルの設置
        CardSyousai.frame = CGRectMake(self.view.frame.width/2-50, self.view.frame.height-140, 220, 120)
        CardPoemu.frame = CGRectMake(self.view.frame.width+150, self.view.frame.height-140, 220, 120)
        CardTopSyousai.frame = CGRectMake(self.view.frame.width/2-50,self.view.frame.height-160,220,20)
        CardTopPoemu.frame = CGRectMake(self.view.frame.width+150, self.view.frame.height-140, 220, 20)
        CardTopSyousai.textAlignment = NSTextAlignment.Center
        CardTopPoemu.textAlignment = NSTextAlignment.Center
        CardTopSyousai.font = UIFont(name: "HelveticaNeue-MediumItalic", size: 18.0)
        CardTopPoemu.font = UIFont(name: "HelveticaNeue-MediumItalic", size: 18.0)
        CardPoemu.alpha = 0.0
        CardTopPoemu.alpha = 0.0
        self.view.addSubview(CardSyousai)
        self.view.addSubview(CardPoemu)
        self.view.addSubview(CardTopSyousai)
        self.view.addSubview(CardTopPoemu)
        
        CardSyousai.text = DB().getCard(pic_id!).cardText?.text
        
        //カードの画像を表示
        camera2View.image = PhotoController().NSSImage((DB().getCard(pic_id!).photo?.photoData)!)
        camera2View.layer.cornerRadius = 30
        camera2View.layer.masksToBounds = true
        
        CardSyousai.numberOfLines = 30
        CardPoemu.numberOfLines = 30
        
        self.CardMap.delegate = self
        
        var region:MKCoordinateRegion = self.CardMap.region
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(DB().getCard(pic_id!).position_x, DB().getCard(pic_id!).position_y) //マップの中心を選択して来た場所に設定
        region.center = location
        region.span.longitudeDelta = 0.005
        region.span.latitudeDelta = 0.005
        
        self.CardMap.setRegion(region, animated: true)
        
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.distanceFilter = kCLHeadingFilterNone
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        myLocationManager.startUpdatingLocation()
        
        let db = DB()
        db.showDBPass()
        var flagTrueIDList: [Int]
        flagTrueIDList = db.getFlagTrueIDArray()
        
        for(var i = 0; i < flagTrueIDList.count; i++){
            PinArray.append(Pin())
            PinArray[i].ID = db.getCard(flagTrueIDList[i]).ID
            PinArray[i].title = db.getCard(flagTrueIDList[i]).spotName
            PinArray[i].text = (db.getCard(flagTrueIDList[i]).cardText?.text)!
            PinArray[i].info = db.getCard(flagTrueIDList[i]).info
            PinArray[i].photo = (db.getCard(flagTrueIDList[i]).photo?.photoData)!
            PinArray[i].categoryID = db.getCard(flagTrueIDList[i]).categoryID
            PinArray[i].x = db.getCard(flagTrueIDList[i]).position_x
            PinArray[i].y = db.getCard(flagTrueIDList[i]).position_y
            PinArray[i].coordinate = CLLocationCoordinate2DMake(PinArray[i].x, PinArray[i].y)
            PinArray[i].imageName = "flag_on.png"
        }
        
        
        self.CardMap.setRegion(region, animated: true)
        
        //選択されたカードのピンを作成
        PinArray.append(Pin())
        PinArray[PinArray.count-1].ID = pic_id!
        PinArray[PinArray.count-1].title = DB().getCard(pic_id!).spotName
        PinArray[PinArray.count-1].text = (DB().getCard(pic_id!).cardText?.text)!
        PinArray[PinArray.count-1].info = DB().getCard(pic_id!).info
        PinArray[PinArray.count-1].x = DB().getCard(pic_id!).position_x
        PinArray[PinArray.count-1].y = DB().getCard(pic_id!).position_y
        PinArray[PinArray.count-1].coordinate = CLLocationCoordinate2DMake(PinArray[PinArray.count-1].x, PinArray[PinArray.count-1].y)
        
        if((flagTrueIDList.indexOf(pic_id!)) != nil){
            PinArray[flagTrueIDList.indexOf(pic_id!)!].imageName = ""
            PinArray[PinArray.count-1].imageName = "picup.png"
        }else{
            PinArray[PinArray.count-1].imageName = "picup.png"
        }
        
        CardTopSyousai.text = "詳細情報"
        CardTopPoemu.text = "スポット紹介"
        CardSyousai.text = PinArray[PinArray.count-1].title! + "\n" + PinArray[PinArray.count-1].info
        CardPoemu.text = PinArray[PinArray.count-1].text
        
        CardMap.addAnnotations(PinArray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        CardMap.showsUserLocation = true
    }
    
    var UserAnnotationTap = 0     //0ならアノテーションをまだタップしていない、1なら一度でも押した状態
    
    //アノテーションがタップされた時に動作する
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        self.UserAnnotationTap = 1
        self.CardLabelShowText = 0
        for(PinAddress = 0; PinAddress < PinArray.count; PinAddress++){
            if(PinArray[PinAddress].hash == view.annotation!.hash){
                CardSyousai.text = PinArray[PinAddress].title! + "\n" + PinArray[PinAddress].info
                camera2View.image = PhotoController().NSSImage((DB().getCard(PinArray[PinAddress].ID).photo?.photoData)!)
                CardPoemu.text = PinArray[PinAddress].text
                break;
            }
        }
    }
    
    // アノテーション表示の管理
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let myIdentifier = "myPin"
        
        var myAnnotation: MKAnnotationView!
        
        // annotationが見つからなかったら新しくannotationを生成.
        if myAnnotation == nil {
            myAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: myIdentifier)
        }
        
        myAnnotation.canShowCallout = true
        
        let cpa = annotation as! Pin
        myAnnotation.image = UIImage(named:cpa.imageName)
        
        myAnnotation.annotation = annotation
        
        return myAnnotation
    }
    
    
    var CardLabelShowText = 0       //0なら詳細情報を表示中、1なら開発者作のポエムを表示中
    
    //カード(カード上の透明なボタン)をタップしたとき
    @IBAction func CardLabelTapped(sender: AnyObject) {
        
        if(CardLabelShowText == 0){     //詳細情報を表示中
            CardLabelShowText = 1
            UIView.animateWithDuration(0.4) { () -> Void in
                //詳細情報を画面外へ
                self.CardSyousai.frame = CGRectMake(-220, self.view.frame.height-140, 220, 120)
                self.CardSyousai.alpha = 0.0
                self.CardTopSyousai.frame = CGRectMake(-220, self.view.frame.height-160, 220, 20)
                self.CardTopSyousai.alpha = 0.0
                
                //スポット紹介を表示
                self.CardPoemu.frame = CGRectMake(self.view.frame.width/2-50, self.view.frame.height-140, 220, 120)
                self.CardPoemu.alpha = 1.0
                self.CardTopPoemu.frame = CGRectMake(self.view.frame.width/2-50, self.view.frame.height-160, 220, 20)
                self.CardTopPoemu.alpha = 1.0
                
                self.ChangeTextButton.setImage(UIImage(named: "back.png"), forState: .Normal)
            }
        }else{      //スポット紹介を表示中
            
            CardLabelShowText = 0
            UIView.animateWithDuration(0.4) { () -> Void in
                //スポット紹介を画面外へ
                self.CardPoemu.alpha = 0.0
                self.CardPoemu.frame = CGRectMake(self.view.frame.width, self.view.frame.height-140, 220, 120)
                self.CardTopPoemu.frame = CGRectMake(self.view.frame.width+30, self.view.frame.height-160, 220, 20)
                self.CardTopPoemu.alpha = 0.0
                
                //詳細情報を表示
                self.CardSyousai.alpha = 1.0
                self.CardSyousai.frame = CGRectMake(self.view.frame.width/2-50, self.view.frame.height-140, 220, 120)
                self.CardTopSyousai.alpha = 1.0
                self.CardTopSyousai.frame = CGRectMake(self.view.frame.width/2-50, self.view.frame.height-160, 220, 20)
                
                self.ChangeTextButton.setImage(UIImage(named: "next.png"), forState: .Normal)
                
            }
        }
    }
    
    @IBAction func backbutton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
