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
    
    @objc dynamic var ID = 0
    @objc dynamic var cardText: CardText?
    @objc dynamic var spotName = ""
    @objc dynamic var info = ""
    @objc dynamic var photo: Photo?
    @objc dynamic var categoryID = 0
    @objc dynamic var position_x: Double = 0
    @objc dynamic var position_y: Double = 0
    @objc dynamic var flag = false
    @objc dynamic var updated = false
    
    override class func primaryKey() -> String {
        return "ID"
    }
    
}

class Category: Object {
    
    @objc dynamic var categoryID = 0
    @objc dynamic var categoryName = ""
    
    override class func primaryKey() -> String {
        return "categoryID"
    }
}

class Photo: Object {
    
    @objc dynamic var photoID = 0
    @objc dynamic var ID = 0
    @objc dynamic var photoData: Data?
    @objc dynamic var photoPath = ""
    @objc dynamic var display = false
    
    override class func primaryKey() -> String {
        return "photoID"
    }
}

class CardText: Object {
    
    @objc dynamic var textID = 0
    @objc dynamic var ID = 0
    @objc dynamic var title = ""
    @objc dynamic var text = ""
    
    override class func primaryKey() -> String {
        return "textID"
    }
    
}
