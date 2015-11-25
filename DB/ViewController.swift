//
//  ViewController.swift
//  DB
//
//  Created by project03A on 2015/10/21.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var IDlabel: UILabel!
    @IBOutlet weak var cardTitle: UITextField!
    @IBOutlet weak var cardText: UITextField!
    @IBOutlet weak var cardInfo: UITextField!
    @IBOutlet weak var cardCategoryID: UITextField!
    @IBOutlet weak var cardPhotoPath: UITextField!
    @IBOutlet weak var cardPositionX: UITextField!
    @IBOutlet weak var cardPositionY: UITextField!
    @IBOutlet weak var cardID: UITextField!
    @IBOutlet weak var photoData: UITextField!
    
    var cardData = CardData()
    let realmPath = DB().getRealmPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DB().copyDB()
        print(realmPath)
        
        //IDlabel.text = String(DB().cardListSize() + 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    //上のaddボタンを押したときの処理
    //テキストエリアの内容をDBに書き込む
    var id = 0
    @IBAction func registerButton(sender: AnyObject) {
        /*
        cardData = CardData()
        id = DB().cardListSize() + 1
        cardData.ID = id
        cardData.title = cardTitle.text!
        cardData.text = cardText.text!
        cardData.info = cardInfo.text!
        cardData.categoryID = Int(cardCategoryID.text!)!
        cardData.photoPath = cardPhotoPath.text!
        cardData.position_x = atof(cardPositionX.text!)
        cardData.position_y = atof(cardPositionY.text!)
        
        DB().addRecord(cardData)
        IDlabel.text = String(id + 1)
        */
    }
    //下のaddボタンを押したときの処理
    //photoPathの値を書き換える
    @IBAction func addPhotoButton(sender: AnyObject) {
        //DB().updatePhotoPath(Int(cardID.text!)!, path: photoData.text!)
    }
    
}