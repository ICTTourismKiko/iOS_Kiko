//
//  DB.swift
//  DB
//
//  Created by project03A on 2015/10/21.
//  Copyright © 2015年 project03A. All rights reserved.
//


import Foundation
import UIKit
import RealmSwift

class DB {
    
    var DBName = "/cardData.realm"
    
    /*　------------------------
    DBを使うための下準備メソッド
    ------------------------ */
    
    //バンドルしたrealmファイルをアプリ内にコピーする
    func copyDB() {
        let dbPath = self.getRealmPath()
        let fileManager = FileManager.default
        let dbName:String? = (Bundle.main.resourcePath)! + DBName
        if !(fileManager.fileExists(atPath: dbPath)) {
            if let source = dbName {
                if !(fileManager.fileExists(atPath: source)) {
                    print("not found in bundle")
                } else {
                    do {
                        try fileManager.copyItem(atPath: source, toPath: dbPath)
                    } catch{
                        print("copy failed")
                    }
                }
            }
        }
    }
    
//    func getRealmPath() -> String {
//        let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory , NSSearchPathDomainMask.UserDomainMask, true)[0]
//        return documentPath.stringByAppendingString(DBName)
//    }
    
    func getRealmPath() -> String {
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory , FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        //let documentPath = NSTemporaryDirectory();
        return documentPath + DBName
    }
    
    /*
    //保存先のパスを返す。DBFileNameをいじれば保存先が変わる。
    func getRealmPath() -> String {
    let DBFileName = "cardData.realm"
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let realmPath = (paths[0] as NSString).stringByAppendingPathComponent(DBFileName)
    return realmPath
    }
    */
    
    /*
    func getRealmPath() -> String {
    return NSBundle.mainBundle().pathForResource("cardData", ofType: "realm")!
    }
    */
    
    /* --------------------------
    DBを使用する基本的なメソッド
    -------------------------- */
    
    //Realmのデータベースが保存されているパスを表示
    func showDBPass(){
        let realmPath = URL(string: self.getRealmPath())!
        do{
            print(try Realm(fileURL: realmPath).configuration.fileURL!)
        }catch{
            print("none")
        }
    }
    
    //カードリストの大きさを返す
    func cardListSize() -> Int {
        let realmPath = URL(string: self.getRealmPath())!
        return try!(Realm(fileURL: realmPath).objects(CardData.self).count)
        
    }
    
    //レコードの追加を行う。IDが同じなら上書きする。
    func addRecord(_ record: Object) {
        
        do {
            let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
            try realm.write {
                realm.add(record, update:true)
            }
        } catch {
            print("かきこみ失敗してるよ")
        }
    }
    
    //IDを受け取って、対応するレコードを返す
    func getCard(_ id: Int) -> CardData {
        
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        let card = realm.objects(CardData.self).filter("ID = %@", id)[0]
        
        return card
    }
    
    func update(_ id: Int, update: Bool){
        let card = getCard(id)
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        try! realm.write{
            card.updated = update
        }
    }
    
    func initAll(){
        for i in 1..<self.cardListSize(){
            self.linkToCardData(self.getDefaultPhoto(i))
            self.linkToCardData(self.getDefaultText(i))
            self.setUpdated(i, flagStatement: false)
        }
    }
    
    /* ---------------------------
    絞り込み検索で使用するメソッド
    --------------------------- */
    
    //フラグの立ってるIDを配列に詰めて返す
    func getFlagTrueIDArray() -> [Int] {
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        let flagTrueList = realm.objects(CardData.self).filter("flag = true")
        var flagTrueID: [Int] = []
        for i in 0..<flagTrueList.count {
            flagTrueID.append(flagTrueList[i].ID)
        }
        return flagTrueID
    }
    
    //カテゴリで絞り込み。カテゴリ条件に対応するIDを配列で返す。
    func getFilteredCategoryIDArray(_ categoryID: Int) -> [Int] {
        
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        let filteredList = realm.objects(CardData.self).filter("categoryID = %@", categoryID)
        var filteredID: [Int] = []
        for i in 0..<filteredList.count {
            filteredID.append(filteredList[i].ID)
        }
        return filteredID
    }
    
    //更新があったカードのIDを配列で返す。
    func getUpdatedCardIDArray() -> [Int] {
        
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        let updatedList = realm.objects(CardData.self).filter("updated = true")
        var updatedID: [Int] = []
        for i in 0..<updatedList.count {
            updatedID.append(updatedList[i].ID)
        }
        return updatedID
    }
    
    /* -------------------------
    写真を扱うために使うメソッド
    ------------------------- */
    
    func getLastPhotoID() -> Int{
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        return (realm.objects(Photo.self).last?.photoID)!
    }
    
    func getPhoto(_ photoID: Int) -> Photo{
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        let photo = realm.objects(Photo.self).filter("photoID = %@", photoID)[0]
        return photo
    }
    
    //写真の追加を行う。
    //カードに対応するIDと写真のデータを受け取って、DBに書き込む
    func addPhoto (_ id: Int, photoData: Data){
        let photo = Photo()
        
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        photo.photoID = (realm.objects(Photo.self).last?.photoID)! + 1
        photo.ID = id
        photo.photoData = photoData
        photo.display = true
        
        addRecord(photo)
        
        update(id, update: true)
    }
    
    //photoIDに対応する写真を削除する
    func deletePhoto(_ photoId: Int){
        
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        
        let photo = realm.objects(Photo.self).filter("photoID = %@", photoId)[0]
        
        //削除する写真がカードにひも付けられている場合
        if realm.objects(CardData.self).filter("ID = %@", photo.ID)[0].photo?.photoID == photo.photoID {
            linkToCardData(getDefaultPhoto(photo.ID))
        }
        if getAllPhoto(photo.ID).count <= 1 {
            update(photo.ID, update: false)
        }
        
        try! realm.write {
            realm.delete(photo)
        }
    }
    
    //IDに対応する写真を全て渡す
    func getAllPhoto(_ id: Int) -> Results<Photo>{
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        return realm.objects(Photo.self).filter("ID = %@", id)
    }
    
    //photoIDに対応する写真をCardDataレコードに対応付ける
    func linkToCardData(_ photo: Photo){
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        let card = getCard(photo.ID)
        try! realm.write {
            card.photo = photo
        }
    }
    
    func linkToCard(_ photoID: Int){
        linkToCardData(getPhoto(photoID))
    }
    
    //IDに対応するデフォルト写真のオブジェクトを返す
    func getDefaultPhoto(_ id: Int) -> Photo {
        return getAllPhoto(id).first!
    }
    
    /* ---------------------------------
    タイトルとテキストの更新で使うメソッド
    --------------------------------- */
    
    //カードのIDとタイトルとテキストを受け取って、レコードを作る
    func updateTitleAndText(_ id: Int, title:String, text: String){
        let cardText = CardText()
        
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        cardText.textID = (realm.objects(CardText.self).last?.textID)! + 1
        
        cardText.ID = id
        cardText.title = title
        cardText.text = text
        
        addRecord(cardText)
        
        linkToCardData(cardText)
    }
    
    //CardDataレコードとCardTextレコードを関連付ける
    func linkToCardData(_ cardText: CardText){
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        let card = getCard(cardText.ID)
        try! realm.write {
            card.cardText = cardText
        }
    }
    
    //デフォルトのテキストを取得
    func getDefaultText(_ id: Int) -> CardText {
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        return realm.objects(CardText.self).filter("ID = %@", id)[0]
        
    }
    
    /*
    //カードのIDとタイトルとテキストを受け取って、対応するレコードに上書きする。
    func updateTitleAndText(id: Int, title: String, text: String){
    
    do{
    let realmPath = self.getRealmPath()
    let realm = try! Realm(path: realmPath)
    let card = getCard(id)
    try realm.write{
    card.title = title
    card.text = text
    card.updated = true
    }
    }catch{
    print("上書き失敗")
    }
    }
    */
    
    /* ----------------------------
    カテゴリを扱うために使うメソッド
    ---------------------------- */
    
    //カテゴリIDに対してカテゴリ名を返す。
    func getCategoryName(_ categoryID: Int) -> String{
        
        let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
        
        return realm.objects(Category.self).filter("categoryID = %@", categoryID)[0].categoryName
    }
    
    /* ------------------------
    フラグを扱うためのメソッド
    ------------------------ */
    
    func getFlagStatement(_ ID: Int) -> Bool{
        return self.getCard(ID).flag
    }
    
    func getFlagStatementList() -> [Bool] {
        var flaglist: [Bool] = []
        for i in 1...self.cardListSize() {
            flaglist.append(self.getCard(i).flag)
        }
        return flaglist
    }
    
    func setFlag(_ ID: Int, flagStatement: Bool){
        do{
            _ = self.getRealmPath()
            let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
            let card = getCard(ID)
            try realm.write{
                card.flag = flagStatement
            }
        }catch{
            print("フラグ値上書き失敗")
        }
    }
    
    func setUpdated(_ ID: Int, flagStatement: Bool){
        do{
            _ = self.getRealmPath()
            let realm = try! Realm(fileURL: URL(string: self.getRealmPath())!)
            let card = getCard(ID)
            try realm.write{
                card.updated = flagStatement
            }
        }catch{
            print("updated値上書き失敗")
        }
    }
    
    
    /* -------------------------
    DBの初期化に使用するメソッド
    ------------------------- */
    
    //DBにIDだけ流し込む
    func initCardData(_ maxID: Int){
        var cardData = CardData()
        for i in 1...maxID {
            cardData = CardData()
            cardData.ID = i
            addRecord(cardData)
        }
    }
    
    //写真のデータとphotoIDを受け取って、対応するレコードに上書きする。
    //DB初期化のときだけ使う。基本addPhoto()で写真の追加を行う。
    func addDefaultPhoto(_ photoId: Int, photoData: Data){
        
        let photo = Photo()
        photo.photoID = photoId
        photo.ID = photoId
        photo.photoData = photoData
        
        addRecord(photo)
    }
    
    //カテゴリテーブルの初期化処理
    var categoryDB = Category()
    func initCategoryDB(){
        let categoryName: [String] = ["散策", "グルメ", "おみやげ"]
        for i in 1...categoryName.count {
            categoryDB = Category()
            categoryDB.categoryID = i
            categoryDB.categoryName = categoryName[i-1]
            addRecord(categoryDB)
        }
    }
    
}
