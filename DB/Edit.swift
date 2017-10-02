//
//  Edit.swift
//  DB
//
//  Created by project03A on 2015/12/06.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class Edit: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var titleNum: UILabel!
    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var contentNum: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var navigation: UINavigationBar!
        
    let db = DB()
    var id = 0
    var card = CardData()
    var defaultText = CardText()
    var cardTitle = ""
    var cardContent = ""
    let titleLength = 13
    let contentLength = 70
    
    var pic_id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, for:. default)
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //選択したIDを持ってくる処理
        pic_id = appDelegate.P_ID!
        
        id = pic_id
        card = db.getCard(id)
        defaultText = db.getDefaultText(id)
        cardTitle = card.cardText!.title
        cardContent = card.cardText!.text
        cardImage.image = PhotoController().NSSImage((card.photo?.photoData)!)
        titleText.text = cardTitle
        contentText.text = cardContent
        
        titleText.becomeFirstResponder()
        
        contentText.delegate = self
        
        NotificationCenter.default.addObserver(self, selector:#selector(Edit.textFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        
        titleNum.text = String(titleLength - titleText.text!.characters.count)
        contentNum.text = String(contentLength - contentText.text.characters.count)
    }
    
    //保存ボタンを押したら
    @IBAction func saveButton(_ sender: AnyObject) {
        //DBに保存して
        let changedTitle = titleText.text
        let changedContent = contentText.text
        
        let myAlert = UIAlertController(title: "", message: "保存しました", preferredStyle: .alert)
        
        if(changedTitle!.characters.count > titleLength){
            myAlert.message = "タイトルは" + String(titleLength) + "文字以内で入力してください"
        }else if((changedContent?.characters.count)! > contentLength){
            myAlert.message = "本文は" + String(contentLength) + "文字以内で入力してください"
        }else{
            if(titleText.text == defaultText.title && contentText.text == defaultText.text) {
                db.linkToCardData(defaultText)
                
            }else if !(titleText.text == cardTitle && contentText.text == cardContent) {
                db.updateTitleAndText(id, title: titleText.text!, text: contentText.text)
                
            }
            cardTitle = changedTitle!
            cardContent = changedContent!
            
        }
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        myAlert.addAction(defaultAction)
        present(myAlert, animated: true, completion: nil)
        
    }
    
    //戻るボタンを押したら、画面を閉じる
    @IBAction func cancelButton(_ sender: AnyObject) {
        if !(titleText.text == cardTitle && contentText.text == cardContent) {
            let alertController = UIAlertController(title: "", message: "変更があります。保存せずに戻りますか？", preferredStyle: .alert)
            let otherAction = UIAlertAction(title: "はい", style: .default) {
                action in self.dismiss(animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "いいえ", style: .default) {
                action in self.titleText.becomeFirstResponder()
            }
            self.view.endEditing(true)
            alertController.addAction(otherAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }else{
            self.view.endEditing(true)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    //戻すボタンを押したら、テキスト切り替え
    @IBAction func defaultButton(_ sender: AnyObject) {
        if !(titleText.text == defaultText.title && contentText.text == defaultText.text)  {
            let alertController = UIAlertController(title: "", message: "変更があります。元に戻しますか？", preferredStyle: .alert)
            let otherAction = UIAlertAction(title: "OK", style: .default) {
                action in self.titleText.text = self.defaultText.title
                self.contentText.text = self.defaultText.text
                self.titleNum.text = String(self.titleLength - self.titleText.text!.characters.count)
                self.contentNum.text = String(self.contentLength - self.contentText.text.characters.count)
            }
            let cancelAction = UIAlertAction(title: "CANCEL", style: .default) {
                action in print("Pushed CANCEL")
            }
            
            alertController.addAction(otherAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    /* Facebookみたいな画像の見方ができる関数 */
    @IBAction func openImage(_ sender: AnyObject) {
        // 1. SKPhotoを作成
        var images = [SKPhoto]()
        let src = NSData(data: (DB().getCard(id).photo?.photoData)!) as Data
        let photo = SKPhoto.photoWithImage(UIImage(data:src)!)// add some UIImage
        images.append(photo)
        
        // 2. PhotoBrowserを作成
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        present(browser, animated: true, completion: {})
    }
    
    func textViewDidChange(_ textView: UITextView){
        contentNum.text = String(contentLength - contentText.text.characters.count)
    }
    
    func textFieldDidChange(_ notification:Notification){
        titleNum.text = String(titleLength - titleText.text!.characters.count)
    }
    
    //写真を元に戻す
    @IBAction func changePhoto(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "", message: "本当に元に戻しますか？", preferredStyle: .alert)
        let otherAction = UIAlertAction(title: "OK", style: .default) {
            action in let photo = DB().getDefaultPhoto(self.pic_id)
            self.cardImage.image = PhotoController().NSSImage(photo.photoData!)
            DB().linkToCardData(photo)
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .default) {
            action in print("CANCEL")
        }
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
