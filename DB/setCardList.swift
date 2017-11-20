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
    
    
    
//    @IBOutlet weak var CellButton: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var MapButton: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var introText: UILabel!
    @IBOutlet weak var tweet: UIButton!
    
//    @IBOutlet weak var open_photo: UIButton!
 //   @IBOutlet weak var flag: UIButton!
    
    
    var flagSituation = false
    var cardID = 0
    let db = DB() //DBのインスタンス生成
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(_ card :cardData) {
        
        
        let height = UIScreen.main.bounds.size.height
        
        //iphoneのサイズによってカードに書かれる文のサイズを変更
        //iPhone6
        if height >= 667 {
            self.title.font = UIFont.boldSystemFont(ofSize:20)
            self.introText.font = UIFont.systemFont(ofSize: 17)
            
            //iPhone6 Plus
                    }else if height == 736 {
            self.title.font = UIFont.boldSystemFont(ofSize:20)
            self.introText.font = UIFont.systemFont(ofSize: 17)
            
            //iPhone5・5s・5c
        }else {
            //self.title.font = UIFont.systemFontOfSize(15)
            self.introText.font = UIFont.systemFont(ofSize: 14)
            self.title.font = UIFont.systemFont(ofSize: 16)
            
        }
        
        self.title.text = card.title as String
        self.introText.text = card.introText as String
        
        // 表示する画像を設定する.
        let myImage = PhotoController().NSSImage(card.imageUrl!)
        self.iconImage.image = myImage
        self.iconImage.layer.cornerRadius = 5
        self.iconImage.layer.masksToBounds = true
        
        cardID = card.id+1
        
    }
    
    /*
        /* フラグボタンの設定 */
        flag.setImage(UIImage(named: "favourites7 (1).png")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        
        flagSituation = card.flag
        
        flagPaint(flagSituation)
        
    }
    
    func flagPaint(_ f :Bool){
        if f == false {
            flag.tintColor = UIColor.lightGray
        }else {
            flag.tintColor = UIColor.orange
        }
    }
    
    /* フラグボタンを押した時の処理 */
    @IBAction func flagOnOff(_ sender: AnyObject) {
        
        
        //フラグ登録してなかったら赤に、してたら元どおりに
        if db.getFlagStatement(appDelegate.P_ID!) == false{
            flag.tintColor = UIColor.orange
            db.setFlag(appDelegate.P_ID!, flagStatement: true)
        } else {
            flag.tintColor = UIColor.lightGray
            db.setFlag(appDelegate.P_ID!, flagStatement: false)
        }
        
        appDelegate.flaglist.removeAll()
        appDelegate.flaglist = DB().getFlagStatementList()
    }
    
 */
}
