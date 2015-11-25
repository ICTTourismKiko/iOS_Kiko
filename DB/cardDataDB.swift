//
//  cardDataDB.swift
//  DB
//
//  Created by project03A on 2015/10/21.
//  Copyright © 2015年 project03A. All rights reserved.
//

import RealmSwift
import UIKit

class CardData: Object {
    
    dynamic var ID = 0
    dynamic var cardText: CardText?
    dynamic var spotName = ""
    dynamic var info = ""
    dynamic var photo: Photo?
    dynamic var categoryID = 0
    dynamic var position_x: Double = 0
    dynamic var position_y: Double = 0
    dynamic var flag = false
    dynamic var updated = false
    
    override class func primaryKey() -> String {
        return "ID"
    }
    
}

class Category: Object {
    
    dynamic var categoryID = 0
    dynamic var categoryName = ""
    
    override class func primaryKey() -> String {
        return "categoryID"
    }
}

class Photo: Object {
    
    dynamic var photoID = 0
    dynamic var ID = 0
    dynamic var photoData: NSData?
    dynamic var photoPath = ""
    dynamic var display = false
    
    override class func primaryKey() -> String {
        return "photoID"
    }
}

class CardText: Object {
    
    dynamic var textID = 0
    dynamic var ID = 0
    dynamic var title = ""
    dynamic var text = ""
    
    override class func primaryKey() -> String {
        return "textID"
    }
    
}
