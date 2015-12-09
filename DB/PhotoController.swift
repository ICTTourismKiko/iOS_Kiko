//
//  PhotoController.swift
//  DB
//
//  Created by 池田俊輝 on 2015/10/23.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class PhotoController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NSTimer.scheduledTimerWithTimeInterval(0.01,target:self,selector:Selector("camerastart"),
            userInfo: nil, repeats: false);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func camerastart(){
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.Camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.presentViewController(cameraPicker, animated: true, completion: nil)
        }
    }
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let image:UIImage! = pickedImage
            //選択したIDを持ってくる処理
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let pic_id = appDelegate.P_ID
            if(image != nil){
                DB().addPhoto(pic_id!, photoData: ImageNSS(image!)!)
                let photoID = DB().getLastPhotoID()
                print(photoID)
                DB().linkToCard(photoID)
            }
            NSTimer.scheduledTimerWithTimeInterval(0.01,target:self,selector:Selector("back"),
                userInfo: nil, repeats: false);
        }
        
        //閉じる処理
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        NSTimer.scheduledTimerWithTimeInterval(0.01,target:self,selector:Selector("back"),
            userInfo: nil, repeats: false);
    }
    
    //写真データをstring型に変換
    func ImageNSS(image:UIImage) -> NSData? {
        
        //画像をNSDataに変換
        let data:NSData = UIImageJPEGRepresentation(image,0.8)!
        
        return data
    }
    
    //NSDataを写真データに変換
    func NSSImage(data:NSData) -> UIImage?{
        
        //NSDataの生成が成功していたら
        let decodeSuccess = data
            
        //NSDataからUIImageを生成
        let img = UIImage(data: decodeSuccess)
            
        //結果を返却
        return img
        
    }
    func back() {
//        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "target" ) 
//        self.presentViewController( targetViewController, animated: true, completion: nil)
        self.dismissViewControllerAnimated(true, completion: nil)        
    }

}
