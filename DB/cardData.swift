//
//  cardData.swift
//  kikou
//
//  Created by FUNAICT201311 on 2015/10/23.
//  Copyright © 2015年 FUNAICT201311. All rights reserved.
//

import Foundation

class cardData : NSObject {
    var title:NSString //タイトル
    var introText:NSString //紹介文
    var imageUrl:NSData? //画像
    var id:Int//カードID
    var flag:Bool //フラグ状態
    
    init(title: String, introText: String,
        imageUrl: NSData?,id:Int,flag:Bool){
            
            self.title = title
            self.introText = introText
            self.imageUrl = imageUrl
            self.id = id
            self.flag = flag
    }
}