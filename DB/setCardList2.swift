//
//  setCardList.swift
//  kikou
//
//  Created by FUNAICT201311 on 2015/10/23.
//  Copyright © 2015年 FUNAICT201311. All rights reserved.
//

import UIKit

class setCardList2: UITableViewCell, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var introText: UILabel!
    
    //暗くする画像のところ
    @IBOutlet weak var select_check: UIImageView!
    
    var cardID = 0
    let appdelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(card :cardData) {
        
        let height = UIScreen.mainScreen().bounds.size.height
        
        //iphoneのサイズによってカードに書かれる文のサイズを変更
        //iPhone6
        if height >= 667 {
            self.introText.font = UIFont.systemFontOfSize(14)
            
            //iPhone6 Plus
            //        }else if height == 736 {
            //            self.introText.font = UIFont.systemFontOfSize(15)
            
            //iPhone5・5s・5c
        }else {
            self.introText.font = UIFont.systemFontOfSize(12)
            self.title.font = UIFont.systemFontOfSize(14)

        }
        
        self.title.text = card.title as String
        self.introText.text = card.introText as String
        // 表示する画像を設定する.
        let myImage = PhotoController().NSSImage(card.imageUrl!)
        self.iconImage.image = myImage
        self.iconImage.layer.cornerRadius = 10
        self.iconImage.layer.masksToBounds = true
        
        cardID = card.id+1
        
        //選んだカードを暗くする機能
        for i in 0..<8 {
            if(cardID==appdelegate.cardID[i]){
                self.select_check.image = UIImage(named: "black.JPG") as UIImage?
                self.select_check.alpha = 0.3
                break
            }else{
                self.select_check.image = nil
            }
        }
        
    }
    
    @IBAction func openImage(sender: AnyObject) {
        appdelegate.P_ID = cardID
    }
    
    @IBAction func select_photo(sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.cardID[appDelegate.picID] = cardID
    }
}
