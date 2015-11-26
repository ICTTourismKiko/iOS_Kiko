//
//  setCardList.swift
//  kikou
//
//  Created by FUNAICT201311 on 2015/10/23.
//  Copyright © 2015年 FUNAICT201311. All rights reserved.
//

import UIKit

class setCardList: UITableViewCell, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    
    
    @IBOutlet weak var CellButton: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var introText: UILabel!
    @IBOutlet weak var open_photo: UIButton!
    @IBOutlet weak var flag: UIButton!
    
    
    var flagSituation = false
    var cardID = 0
    let db = DB() //DBのインスタンス生成
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(card :cardData) {
        
        self.title.text = card.title as String
        self.introText.text = card.introText as String
            // 表示する画像を設定する.
        let myImage = PhotoController().NSSImage(card.imageUrl!)
        self.iconImage.image = myImage
        self.iconImage.layer.cornerRadius = 10
        self.iconImage.layer.masksToBounds = true
        
        cardID = card.id+1
        
        /* フラグボタンの設定 */
       flag.setImage(UIImage(named: "flag.png")?.imageWithRenderingMode(.AlwaysTemplate), forState: UIControlState.Normal)
        
       flagSituation = card.flag
        
       flagPaint(flagSituation)
        
    }
    
    func flagPaint(f :Bool){
      if f == false {
            flag.tintColor = UIColor.lightGrayColor()
        }else {
            flag.tintColor = UIColor.redColor()
        }
    }
    
    //写真を選択したときに、IDを渡す
    @IBAction func open_photo(sender: AnyObject) {
        appDelegate.P_ID = cardID
    }
    //mapボタン
    @IBAction func CellButtonTapped(sender: AnyObject) {
        appDelegate.P_ID = cardID
    }
    
    /* フラグボタンを押した時の処理 */
    @IBAction func flagOnOff(sender: AnyObject) {
        appDelegate.P_ID = cardID
        
        //フラグ登録してなかったら赤に、してたら元どおりに
        if db.getFlagStatement(appDelegate.P_ID!) == false{
            flag.tintColor = UIColor.redColor()
            db.setFlag(appDelegate.P_ID!, flagStatement: true)
        } else {
            flag.tintColor = UIColor.lightGrayColor()
            db.setFlag(appDelegate.P_ID!, flagStatement: false)
        }
    }
    
}
