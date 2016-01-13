//
//  Edit.swift
//  DB
//
//  Created by project03A on 2015/12/06.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class Edit: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    @IBOutlet weak var titleText: UITextView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, forBarMetrics:. Default)
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        id = appDelegate.P_ID!
        card = db.getCard(id)
        defaultText = db.getDefaultText(id)
        cardTitle = card.cardText!.title
        cardContent = card.cardText!.text
        cardImage.image = PhotoController().NSSImage((card.photo?.photoData)!)
        titleText.text = cardTitle
        contentText.text = cardContent
        
        titleText.becomeFirstResponder()
        
        titleText.delegate = self
        contentText.delegate = self
        
        titleNum.text = String(titleLength - titleText.text.characters.count)
        contentNum.text = String(contentLength - contentText.text.characters.count)
        
    }
    
    //保存ボタンを押したら
    @IBAction func saveButton(sender: AnyObject) {
        //DBに保存して
        let changedTitle = titleText.text
        let changedContent = contentText.text
        
        let myAlert = UIAlertController(title: "", message: "保存しました", preferredStyle: .Alert)
        
        if(changedTitle.characters.count > titleLength){
            myAlert.message = "タイトルは" + String(titleLength) + "文字以内で入力してください"
        }else if(changedContent.characters.count > contentLength){
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
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        myAlert.addAction(defaultAction)
        presentViewController(myAlert, animated: true, completion: nil)

    }
    
    //戻るボタンを押したら、画面を閉じる
    @IBAction func cancelButton(sender: AnyObject) {
        if !(titleText.text == cardTitle && contentText.text == cardContent) {
            let alertController = UIAlertController(title: "", message: "変更があります。保存せずに戻りますか？", preferredStyle: .Alert)
            let otherAction = UIAlertAction(title: "はい", style: .Default) {
                action in self.dismissViewControllerAnimated(true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "いいえ", style: .Default) {
                action in self.titleText.becomeFirstResponder()
            }
            self.view.endEditing(true)
            alertController.addAction(otherAction)
            alertController.addAction(cancelAction)
            presentViewController(alertController, animated: true, completion: nil)
        }else{
            self.view.endEditing(true)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    //戻すボタンを押したら、テキスト切り替え
    @IBAction func defaultButton(sender: AnyObject) {
        if !(titleText.text == defaultText.title && contentText.text == defaultText.text)  {
            let alertController = UIAlertController(title: "", message: "変更があります。元に戻しますか？", preferredStyle: .Alert)
            let otherAction = UIAlertAction(title: "OK", style: .Default) {
                action in self.titleText.text = self.defaultText.title
                self.contentText.text = self.defaultText.text
                self.titleNum.text = String(self.titleLength - self.titleText.text.characters.count)
                self.contentNum.text = String(self.contentLength - self.contentText.text.characters.count)
            }
            let cancelAction = UIAlertAction(title: "CANCEL", style: .Default) {
                action in print("Pushed CANCEL")
            }
            
            alertController.addAction(otherAction)
            alertController.addAction(cancelAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    func textViewDidChange(textView: UITextView){
        titleNum.text = String(titleLength - titleText.text.characters.count)
        contentNum.text = String(contentLength - contentText.text.characters.count)
    }
}