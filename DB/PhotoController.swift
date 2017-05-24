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
        
        Timer.scheduledTimer(timeInterval: 1.0,target:self,selector:#selector(PhotoController.showActionSheet),
            userInfo: nil, repeats: false);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var CA_check = 0//1の時は、カメラを起動した、0の時はアルバム起動した
    
    //選択画面表示メソッド
    func showActionSheet(){
        
        // インスタンス生成　styleはActionSheet.
        let myAlert = UIAlertController(title: "選択して下さい", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // アクションを生成.
        let myAction_1 = UIAlertAction(title: "カメラで写真を撮る", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            self.camerastart()
            
        })
        let myAction_2 = UIAlertAction(title: "アルバムから写真を選ぶ", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            self.pickImageFromLibrary()
        })
        let myAction_3 = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: {
            (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        })
        
        // アクションを追加.
        myAlert.addAction(myAction_1)
        myAlert.addAction(myAction_2)
        myAlert.addAction(myAction_3)
        
        self.present(myAlert, animated: true, completion: nil)
    }

    // ライブラリから写真を選択する
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    func camerastart(){
        CA_check = 1
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let image:UIImage! = pickedImage
            //選択したIDを持ってくる処理
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let pic_id = appDelegate.P_ID
            if(image != nil){
                DB().addPhoto(pic_id!, photoData: ImageNSS(image!)!)
                let photoID = DB().getLastPhotoID()
                print(photoID)
                DB().linkToCard(photoID)
            }
            
            //ライブラリに写真を保存
            if(CA_check==1){
                if image != nil {
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(PhotoController.image(_:didFinishSavingWithError:contextInfo:)), nil)
                }
            }
            
            
            Timer.scheduledTimer(timeInterval: 0.01,target:self,selector:#selector(PhotoController.back),
                userInfo: nil, repeats: false);
        }
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //ライブラリに写真を保存するときのエラー内容表示
    func image(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print(error.code)
        }
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        Timer.scheduledTimer(timeInterval: 0.01,target:self,selector:#selector(PhotoController.back),
            userInfo: nil, repeats: false);
    }
    
    //写真データをstring型に変換
    func ImageNSS(_ image:UIImage) -> Data? {
        
        //画像をNSDataに変換
        let data:Data = UIImageJPEGRepresentation(image,0.8)!
        
        return data
    }
    
    //NSDataを写真データに変換
    func NSSImage(_ data:Data) -> UIImage?{
        
        //NSDataの生成が成功していたら
        let decodeSuccess = data
            
        //NSDataからUIImageを生成
        let img = UIImage(data: decodeSuccess)
            
        //結果を返却
        return img
        
    }
    func back() {
        self.dismiss(animated: true, completion: nil)
    }

}
