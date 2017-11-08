//
//  Map.swift
//  DB
//
//  Created by 岩見建汰 on 2015/10/22.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit
import MapKit
import SKPhotoBrowser
var CardTopSyousai = ["詳細","タイトル","Info","スポット紹介","info"]

class Map: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate, UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CardTopSyousai.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        // セルの背景色はなし
        cell.backgroundColor = UIColor.clear
        // セルに表示する値を設定する
        cell.textLabel!.text = CardTopSyousai[indexPath.row]
        cell.textLabel!.textAlignment = .center
        cell.textLabel!.numberOfLines = 0
        if (indexPath.row == 0 || indexPath.row == 3) {
            cell.textLabel!.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        }else{
            cell.textLabel!.font = UIFont(name:"ArialHebew", size:UIFont.labelFontSize)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // セルの高さの見積もり
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBOutlet weak var CardMap: MKMapView!
    @IBOutlet weak var camera2View: UIImageView!
    @IBOutlet weak var navigation: UINavigationBar!
    @IBOutlet weak var ChangeTextButton: UIButton!
   // @IBOutlet weak var arrow: UIImageView!
    
    var myLocationManager: CLLocationManager!
    
    
    class Pin : MKPointAnnotation{
        var ID = 0
        var text = ""
        var info = ""
        var photo = Data()
        var categoryID = 0
        var x: Double = 0.0
        var y: Double = 0.0
        var imageName = ""
    }
    
    var PinArray: Array<Pin> = []
    var PinAddress = 0
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var pic_id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //ChangeTextButton.setImage(UIImage(named: "next.png"), forState: .Normal)
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, for:. default)
        
        //選択したIDを持ってくる処理
        pic_id = appDelegate.P_ID!
        let deletePic = pic_id
        
        //カードの画像を表示
        camera2View.image = PhotoController().NSSImage((DB().getCard(pic_id).photo?.photoData)!)
        camera2View.layer.cornerRadius = 10
        camera2View.layer.masksToBounds = true
        
        let db = DB()
        db.showDBPass()
        var flagTrueIDList: [Int]
        flagTrueIDList = db.getFlagTrueIDArray()
        
        for i in 0..<flagTrueIDList.count{
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
            PinArray[i].imageName = "fa3.png"
        }
        
        //選択されたカードのピンを作成
        PinArray.append(Pin())
        PinArray[PinArray.count-1].ID = pic_id
        PinArray[PinArray.count-1].title = DB().getCard(pic_id).spotName
        PinArray[PinArray.count-1].text = (DB().getCard(pic_id).cardText?.text)!
        PinArray[PinArray.count-1].info = DB().getCard(pic_id).info
        PinArray[PinArray.count-1].x = DB().getCard(pic_id).position_x
        PinArray[PinArray.count-1].y = DB().getCard(pic_id).position_y
        PinArray[PinArray.count-1].coordinate = CLLocationCoordinate2DMake(PinArray[PinArray.count-1].x, PinArray[PinArray.count-1].y)
        
        if((flagTrueIDList.index(of: pic_id)) != nil){
            PinArray[flagTrueIDList.index(of: pic_id)!].imageName = ""
            PinArray[PinArray.count-1].imageName = "redpin30px.png"
        }else{
            PinArray[PinArray.count-1].imageName = "redpin30px.png"
        }

        
        CardMap.addAnnotations(PinArray)
        
        //カードの情報を設定
        CardTopSyousai = ["詳細",PinArray[PinArray.count-1].title!,PinArray[PinArray.count-1].info,"スポット紹介",PinArray[PinArray.count-1].text]
        
        for i in 1..<17{
            appDelegate.P_ID = i
            pic_id = appDelegate.P_ID!
            if(pic_id != deletePic){
        //選択されたカードのピンを作成
            PinArray.append(Pin())
            PinArray[PinArray.count-1].ID = pic_id
            PinArray[PinArray.count-1].title = DB().getCard(pic_id).spotName
            PinArray[PinArray.count-1].text = (DB().getCard(pic_id).cardText?.text)!
            PinArray[PinArray.count-1].info = DB().getCard(pic_id).info
            PinArray[PinArray.count-1].x = DB().getCard(pic_id).position_x
            PinArray[PinArray.count-1].y = DB().getCard(pic_id).position_y
            PinArray[PinArray.count-1].coordinate = CLLocationCoordinate2DMake(PinArray[PinArray.count-1].x, PinArray[PinArray.count-1].y)
            if((flagTrueIDList.index(of: pic_id)) != nil){
                PinArray[flagTrueIDList.index(of: pic_id)!].imageName = ""
                PinArray[PinArray.count-1].imageName = "ic_location_on_36pt_3x.png"
            }else{
                PinArray[PinArray.count-1].imageName = "ic_location_on_36pt_3x.png"
            }
            CardMap.addAnnotations(PinArray)
            }
        }
            
        
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.distanceFilter = kCLHeadingFilterNone
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        myLocationManager.startUpdatingLocation()
        
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.notDetermined) {
            //print("didChangeAuthorizationStatus:\(status)");
            self.myLocationManager.requestAlwaysAuthorization()
        }
        
        /** 位置情報取得失敗時 */
         self.CardMap.delegate = self
        
        var region:MKCoordinateRegion = self.CardMap.region
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(DB().getCard(appDelegate.P_ID!).position_x, DB().getCard(appDelegate.P_ID!).position_y) //マップの中心を選択して来た場所に設定
        
        region.center = location
        region.span.longitudeDelta = 0.005
        region.span.latitudeDelta = 0.005
        
        self.CardMap.setRegion(region, animated: true)
        
        
        /** 位置情報取得成功時 */
        
//        // 出発点の緯度、経度を設定.
//        let myLatitude: CLLocationDegrees = (myLocationManager.location?.coordinate.latitude)!
//        let myLongitude: CLLocationDegrees = (myLocationManager.location?.coordinate.longitude)!
//        
//        // 目的地の緯度、経度を設定.
//        let requestLatitude: CLLocationDegrees = PinArray[PinArray.count-1].x
//        let requestLongitude: CLLocationDegrees = PinArray[PinArray.count-1].y
//        
//        // Delegateを設定.
//        self.CardMap.delegate = self
//        
//        // 地図の中心を出発点と目的地の中間に設定する.
//        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake((myLatitude + requestLatitude)/2, (myLongitude + requestLongitude)/2)
//        
//        // mapViewに中心をセットする.
//        CardMap.setCenterCoordinate(center, animated: true)
//        
//        // 縮尺を指定.
//        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
//        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: center, span: mySpan)
//        
//        CardMap.region = myRegion
//        
//        // viewにmapViewを追加.
//        self.view.addSubview(CardMap)
//        
//        
//        //***　ここから経路表示機能
//        let request = MKDirectionsRequest()
//        // 出発地をセット.
//        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: myLatitude, longitude: myLongitude), addressDictionary: nil))
//        //目的地をセット.
//        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: requestLatitude, longitude: requestLongitude), addressDictionary: nil))
//        
//        // 複数経路の検索を有効.
//        request.requestsAlternateRoutes = true
//        
//        // 移動手段を歩きに設定.
//        request.transportType = MKDirectionsTransportType.Walking
//        
//        // MKDirectionsを生成してRequestをセット.
//        let directions = MKDirections(request: request)
//        
//        // 経路探索.
//        directions.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
//            guard response != nil else { return }
//            
//            let route: MKRoute = response!.routes[0] as MKRoute
//            
//            print("目的地まで \(route.distance)m")
//            print("所要時間 \(Int(route.expectedTravelTime/60))分")
//            
//            // mapViewにルートを描画.
//            self.CardMap.addOverlay(route.polyline)
//        }
//        
//        // 現在地と目的地を含む矩形を計算
//        let maxLat:Double = fmax(myLatitude,  requestLatitude)
//        let maxLon:Double = fmax(myLongitude, requestLongitude)
//        let minLat:Double = fmin(myLatitude,  requestLatitude)
//        let minLon:Double = fmin(myLongitude, requestLongitude)
//        
//        // 地図表示するときの緯度、経度の幅を計算
//        let mapMargin:Double = 1.5;  // 経路が入る幅(1.0)＋余白(0.5)
//        let leastCoordSpan:Double = 0.005;    // 拡大表示したときの最大値
//        let span_x:Double = fmax(leastCoordSpan, fabs(maxLat - minLat) * mapMargin);
//        let span_y:Double = fmax(leastCoordSpan, fabs(maxLon - minLon) * mapMargin);
//        
//        let span:MKCoordinateSpan = MKCoordinateSpanMake(span_x, span_y);
//        
//        // 現在地を目的地の中心を計算
//        let center2:CLLocationCoordinate2D = CLLocationCoordinate2DMake((maxLat + minLat) / 2, (maxLon + minLon) / 2);
//        let region:MKCoordinateRegion = MKCoordinateRegionMake(center2, span);
//        
//        CardMap.setRegion(CardMap.regionThatFits(region), animated:true);
        
    }
    
    // 位置情報取得成功時に呼ばれます
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        /** 位置情報取得成功時 */
        
        print("緯度：\(manager.location!.coordinate.latitude)")
        print("経度：\(manager.location!.coordinate.longitude)")
        
        CardMap.showsUserLocation = true
    }
    
    // 位置情報取得失敗時に呼ばれます
    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error){
        print("error")
    }
    
    
    // 経路を描画するときの色や線の太さを指定
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    var UserAnnotationTap = 0     //0ならアノテーションをまだタップしていない、1なら一度でも押した状態
    
    //アノテーションがタップされた時に動作する
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.UserAnnotationTap = 1
        for PinAddress in 0..<PinArray.count {
            if(PinArray[PinAddress].hash == view.annotation!.hash){
//                CardSyousai.text = PinArray[PinAddress].title! + "\n" + PinArray[PinAddress].info
//                camera2View.image = PhotoController().NSSImage((DB().getCard(PinArray[PinAddress].ID).photo?.photoData)!)
//                CardPoemu.text = PinArray[PinAddress].text
                
                appDelegate.P_ID = PinArray[PinAddress].ID
                break;
            }
        }
    }
    
    // アノテーション表示の管理
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
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
    
    /* Facebookみたいな画像の見方ができる関数 */
    @IBAction func openImage(_ sender: AnyObject) {
        // 1. SKPhoto作成
        var images = [SKPhoto]()
        let src = NSData(data: (DB().getCard(pic_id).photo?.photoData)!) as Data
        let photo = SKPhoto.photoWithImage(UIImage(data:src)!)// add some UIImage
        images.append(photo)
        
        // 2. PhotoBrowser作成
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        present(browser, animated: true, completion: {})
    }
    
    @IBAction func backbutton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
