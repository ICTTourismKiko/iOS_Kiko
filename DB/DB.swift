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
        let fileManager = NSFileManager.defaultManager()
        if !(fileManager.fileExistsAtPath(dbPath)) {
            if let source = NSBundle.mainBundle().resourcePath?.stringByAppendingString(DBName) {
                if !(fileManager.fileExistsAtPath(source)) {
                    print("not found in bundle")
                } else {
                    do {
                        try fileManager.copyItemAtPath(source, toPath: dbPath)
                    } catch{
                        print("copy failed")
                    }
                }
            }
        }
    }
    
    func getRealmPath() -> String {
        let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory , NSSearchPathDomainMask.UserDomainMask, true)[0]
        return documentPath.stringByAppendingString(DBName)
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
        let realmPath = self.getRealmPath()
        
        do{
            print(try Realm(path: realmPath).path)
        }catch{
            print("none")
        }
    }
    
    //カードリストの大きさを返す
    func cardListSize() -> Int {
        
        let realmPath = self.getRealmPath()
        return try!(Realm(path: realmPath).objects(CardData).count)
        
    }
    
    //レコードの追加を行う。IDが同じなら上書きする。
    func addRecord(record: Object) {
        
        do {
            let realm = try! Realm(path: getRealmPath())
            try realm.write {
                realm.add(record, update:true)
            }
        } catch {
            print("かきこみ失敗してるよ")
        }
    }
    
    //IDを受け取って、対応するレコードを返す
    func getCard(id: Int) -> CardData {
        
        let realm = try! Realm(path: getRealmPath())
        let card = realm.objects(CardData).filter("ID = %@", id)[0]
        
        return card
    }
    
    func update(id: Int, update: Bool){
        let card = getCard(id)
        let realm = try! Realm(path: getRealmPath())
        try! realm.write{
            card.updated = update
        }
    }
    
    func initAll(){
        for i in 1..<self.cardListSize(){
            self.linkToCardData(self.getDefaultPhoto(i))
            self.linkToCardData(self.getDefaultText(i))
        }
    }
    
    /* ---------------------------
    絞り込み検索で使用するメソッド
    --------------------------- */
    
    //フラグの立ってるIDを配列に詰めて返す
    func getFlagTrueIDArray() -> [Int] {
        let realm = try! Realm(path: getRealmPath())
        let flagTrueList = realm.objects(CardData).filter("flag = true")
        var flagTrueID: [Int] = []
        for(var i=0; i<flagTrueList.count; i++){
            flagTrueID.append(flagTrueList[i].ID)
        }
        return flagTrueID
    }
    
    //カテゴリで絞り込み。カテゴリ条件に対応するIDを配列で返す。
    func getFilteredCategoryIDArray(categoryID: Int) -> [Int] {
        
        let realm = try! Realm(path: getRealmPath())
        let filteredList = realm.objects(CardData).filter("categoryID = %@", categoryID)
        var filteredID: [Int] = []
        for(var i=0; i<filteredList.count; i++){
            filteredID.append(filteredList[i].ID)
        }
        return filteredID
    }
    
    //更新があったカードのIDを配列で返す。
    func getUpdatedCardIDArray() -> [Int] {
        
        let realm = try! Realm(path: getRealmPath())
        let updatedList = realm.objects(CardData).filter("updated = true")
        var updatedID: [Int] = []
        for(var i=0; i<updatedList.count; i++){
            updatedID.append(updatedList[i].ID)
        }
        return updatedID
    }
    
    /* -------------------------
    写真を扱うために使うメソッド
    ------------------------- */
    
    func getLastPhotoID() -> Int{
        let realm = try! Realm(path: getRealmPath())
        return (realm.objects(Photo).last?.photoID)!
    }
    
    func getPhoto(photoID: Int) -> Photo{
        let realm = try! Realm(path: getRealmPath())
        let photo = realm.objects(Photo).filter("photoID = %@", photoID)[0]
        return photo
    }
    
    //写真の追加を行う。
    //カードに対応するIDと写真のデータを受け取って、DBに書き込む
    func addPhoto (id: Int, photoData: NSData){
        let photo = Photo()
        
        let realm = try! Realm(path: getRealmPath())
        photo.photoID = (realm.objects(Photo).last?.photoID)! + 1
        photo.ID = id
        photo.photoData = photoData
        photo.display = true
        
        addRecord(photo)
        
        update(id, update: true)
    }
    
    //photoIDに対応する写真を削除する
    func deletePhoto(photoId: Int){
        
        let realm = try! Realm(path: getRealmPath())
        
        let photo = realm.objects(Photo).filter("photoID = %@", photoId)[0]
        
        //削除する写真がカードにひも付けられている場合
        if realm.objects(CardData).filter("ID = %@", photo.ID)[0].photo?.photoID == photo.photoID {
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
    func getAllPhoto(id: Int) -> Results<Photo>{
        let realm = try! Realm(path: getRealmPath())
        return realm.objects(Photo).filter("ID = %@", id)
    }
    
    //photoIDに対応する写真をCardDataレコードに対応付ける
    func linkToCardData(photo: Photo){
        let realm = try! Realm(path: getRealmPath())
        let card = getCard(photo.ID)
        try! realm.write {
            card.photo = photo
        }
    }
    
    func linkToCard(photoID: Int){
        linkToCardData(getPhoto(photoID))
    }
    
    //IDに対応するデフォルト写真のオブジェクトを返す
    func getDefaultPhoto(id: Int) -> Photo {
        return getAllPhoto(id).first!
    }
    
    /* ---------------------------------
    タイトルとテキストの更新で使うメソッド
    --------------------------------- */
    
    //カードのIDとタイトルとテキストを受け取って、レコードを作る
    func updateTitleAndText(id: Int, title:String, text: String){
        let cardText = CardText()
        
        let realm = try! Realm(path: getRealmPath())
        cardText.textID = (realm.objects(CardText).last?.textID)! + 1
        
        cardText.ID = id
        cardText.title = title
        cardText.text = text
        
        addRecord(cardText)
        
        linkToCardData(cardText)
    }
    
    //CardDataレコードとCardTextレコードを関連付ける
    func linkToCardData(cardText: CardText){
        let realm = try! Realm(path: getRealmPath())
        let card = getCard(cardText.ID)
        try! realm.write {
            card.cardText = cardText
        }
    }
    
    //デフォルトのテキストを取得
    func getDefaultText(id: Int) -> CardText {
        let realm = try! Realm(path: getRealmPath())
        return realm.objects(CardText).filter("ID = %@", id)[0]
        
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
    func getCategoryName(categoryID: Int) -> String{
        
        let realm = try! Realm(path: getRealmPath())
        
        return realm.objects(Category).filter("categoryID = %@", categoryID)[0].categoryName
    }
    
    /* ------------------------
    フラグを扱うためのメソッド
    ------------------------ */
    
    func getFlagStatement(ID: Int) -> Bool{
        return self.getCard(ID).flag
    }
    
    func getFlagStatementList() -> [Bool] {
        var flaglist: [Bool] = []
        for(var i=1; i<=self.cardListSize(); i++){
            flaglist.append(self.getCard(i).flag)
        }
        return flaglist
    }
    
    func setFlag(ID: Int, flagStatement: Bool){
        do{
            let realmPath = self.getRealmPath()
            let realm = try! Realm(path: realmPath)
            let card = getCard(ID)
            try realm.write{
                card.flag = flagStatement
            }
        }catch{
            print("フラグ値上書き失敗")
        }
    }
    
    
    /* -------------------------
    DBの初期化に使用するメソッド
    ------------------------- */
    
    //DBにIDだけ流し込む
    func initCardData(maxID: Int){
        var cardData = CardData()
        for(var i=1; i<=maxID; i++){
            cardData = CardData()
            cardData.ID = i
            addRecord(cardData)
        }
    }
    
    //写真のデータとphotoIDを受け取って、対応するレコードに上書きする。
    //DB初期化のときだけ使う。基本addPhoto()で写真の追加を行う。
    func addDefaultPhoto(photoId: Int, photoData: NSData){
        
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
        for(var i=1; i<=categoryName.count; i++){
            categoryDB = Category()
            categoryDB.categoryID = i
            categoryDB.categoryName = categoryName[i-1]
            addRecord(categoryDB)
        }
    }
    
}
