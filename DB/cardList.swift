//
//  cardList.swift
//  DB
//
//  Created by FUNAICT201311 on 2015/10/26.
//  Copyright © 2015年 project03A. All rights reserved.
//

import Foundation
import UIKit
import SKPhotoBrowser

class cardList: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigation: UINavigationBar!
    
    var cards:[cardData] = [cardData]()
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, for:. default)
        
        self.setupLists()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
        let image = UIImage(named: "tablebackground.png")
        imageView.image = image
        self.tableView.backgroundView = imageView
        
        //        NSTimer.scheduledTimerWithTimeInterval(0.5,target:self,selector:Selector("reload"),
        //            userInfo: nil, repeats: true);
        
        
        //NSTimer.scheduledTimerWithTimeInterval(0.5,target:self,selector:Selector("reload"), userInfo: nil, repeats: true);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //UIScrollBar表示時にスクロールバーをフラッシュ表示
        tableView.flashScrollIndicators()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reload()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLists() {
        for i in 1...DB().cardListSize(){
            let card = DB().getCard(i)
            let f1 = cardData(title: card.cardText!.title,
                              introText: card.cardText!.text, imageUrl: NSData(data: (DB().getCard(i).photo?.photoData)!) as Data,id: i-1,flag:DB().getFlagStatement(i))
            cards.append(f1)
        }
    }
    
    
    // functions needed to be implemented
    // for table view
    
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セクションの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        let cell: setCardList = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! setCardList
        cell.setCell(cards[indexPath.row])
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        
        if appDelegate.flaglist[indexPath.row] == true {
            cell.flag.tintColor = UIColor.orange
        }else {
            cell.flag.tintColor = UIColor.lightGray
        }
        
        return cell
    }
    
    func reload(){
        cards.removeAll()
        setupLists()
        tableView.reloadData()
    }
    
    /* Facebookみたいな画像の見方ができる関数 */
    @IBAction func openImage(_ sender: Any) {
        
        // 押されたボタンを取得
        let botton = sender as! UIButton
        let cell = botton.superview?.superview as! setCardList
        
        // クリックされたcellの位置を取得
        let row = tableView.indexPath(for: cell)?.row
        
        // 1. SKPhoto作成
        var images = [SKPhoto]()
        let src = NSData(data: (DB().getCard(row!+1).photo?.photoData)!) as Data
        let photo = SKPhoto.photoWithImage(UIImage(data:src)!)// add some UIImage
        images.append(photo)
        
        // 2. PhotoBrowse作成
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        present(browser, animated: true, completion: {})
    }
    
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

