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
    
    @IBOutlet weak var CardTop: UILabel!
    @IBOutlet weak var CardLabel: UILabel!
    @IBOutlet weak var CardMap: MKMapView!
    @IBOutlet weak var camera2View: UIImageView!
    @IBOutlet weak var navigation: UINavigationBar!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //テストのため、フラグを全てたてる
//        for(var i = 0; i < DB().cardListSize(); i++){
//              DB().setFlag(i+1, flagStatement: true)
//        }
        
        let navBarImage = UIImage(named: "leaf.jpg") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, forBarMetrics:. Default)
        
        //選択したIDを持ってくる処理
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let pic_id = appDelegate.P_ID
        
        
        CardLabel.text = DB().getCard(pic_id!).cardText?.text
        //カードの画像を表示
        camera2View.image = PhotoController().NSSImage((DB().getCard(pic_id!).photo?.photoData)!)
        camera2View.layer.cornerRadius = 30
        camera2View.layer.masksToBounds = true

        CardLabel.numberOfLines = 30
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
        
        CardTop.text = "詳細情報"
        CardLabel.text = PinArray[PinArray.count-1].title! + "\n" + PinArray[PinArray.count-1].info
        
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
                CardLabel.text = PinArray[PinAddress].title! + "\n" + PinArray[PinAddress].info
                CardTop.text = "詳細情報"
                camera2View.image = PhotoController().NSSImage((DB().getCard(PinArray[PinAddress].ID).photo?.photoData)!)
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
        var ShowLabelNumber = 0
        if(UserAnnotationTap == 0){   //アノテーションを一度もタップしていない
            ShowLabelNumber = PinArray.count-1
        }else{
            ShowLabelNumber = PinAddress
        }
        
        if(CardLabelShowText == 0){
            CardLabelShowText = 1
            UIView.animateWithDuration(0.7) { () -> Void in
                self.CardLabel.transform = CGAffineTransformScale(self.CardLabel.transform, 1.0, -1.0)
                self.CardLabel.alpha = 0.0
            }
            
            UIView.animateWithDuration(0.7) { () -> Void in
                self.CardLabel.alpha = 1.0
                self.CardLabel.transform = CGAffineTransformScale(self.CardLabel.transform, 1.0, -1.0)
                self.CardTop.text = "スポット紹介"
                self.CardLabel.text = self.PinArray[ShowLabelNumber].title! + "\n" + self.PinArray[ShowLabelNumber].text
            }
        }else{
            
            CardLabelShowText = 0
            UIView.animateWithDuration(0.7) { () -> Void in
                self.CardLabel.transform = CGAffineTransformScale(self.CardLabel.transform, 1.0, -1.0)
                self.CardLabel.alpha = 0.0
            }
            
            UIView.animateWithDuration(0.7) { () -> Void in
                self.CardLabel.alpha = 1.0
                self.CardLabel.transform = CGAffineTransformScale(self.CardLabel.transform, 1.0, -1.0)
                self.CardTop.text = "詳細情報"
                self.CardLabel.text =  self.PinArray[ShowLabelNumber].title! + "\n" + self.PinArray[ShowLabelNumber].info
            }
            
        }
    }
    
    
}
