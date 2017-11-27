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
    override func viewDidLoad() {
        super.viewDidLoad()
        DB().showDBPass()
//        let miso = DB().getCard(7)
//        let realm = try! Realm(fileURL: NSURL(string: DB().getRealmPath())!)
//        do{
//            try realm.write(){
//                miso.position_x = 41.674582
//                miso.position_y = 140.438397
//            }
//        }catch{
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//    @IBAction func initButton(sender: AnyObject) {
//        DB().initAll()
//    }
    
    
    /* 「観光する」を選択 */
    @IBAction func moveList(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "cardList", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController()!
        present(next, animated: true, completion: nil)
    }
    
    /* 「振り返る」を選択 */
    /*@IBAction func moveAlbum(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "cardList", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController()!
        present(next, animated: true, completion: nil)
    }*/
    @IBAction func moveAlbum(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "diary", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController()!
        present(next, animated: true, completion: nil)
    }
    /* 「印刷する」を選択 */
    @IBAction func moveCL(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "TempSelect", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController()!
        present(next, animated: true, completion: nil)
    }
    
    /* 利用規約画面へ移動 */
    @IBAction func moveInfo(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "information", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController()!
        present(next, animated: true, completion: nil)
    }
}

