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

class cardList2: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var navi: UINavigationBar!
    
    var cards:[cardData] = [cardData]()
    let set = setCardList2()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navi.setBackgroundImage(navBarImage, for:. default)
        
        self.setupLists()
        
        self.tableView2.delegate = self
        self.tableView2.dataSource = self
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView2.frame.width, height: self.tableView2.frame.height))
        let image = UIImage(named: "tablebackground.png")
        imageView.image = image
        self.tableView2.backgroundView = imageView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //UIScrollBar表示時にスクロールバーをフラッシュ表示
        tableView2.flashScrollIndicators()
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
        let cell: setCardList2 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! setCardList2
        cell.setCell(cards[indexPath.row])
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        return cell
    }
    
    /* Facebookみたいな画像の見方ができる関数 */
    @IBAction func openImage(_ sender: Any) {
        // 押されたボタンを取得
        let botton = sender as! UIButton
        let cell = botton.superview?.superview as! setCardList2
        
        // クリックされたcellの位置を取得
        let row = tableView2.indexPath(for: cell)?.row
        
        // 1. SKPhoto作成
        var images = [SKPhoto]()
        let src = NSData(data: (DB().getCard(row!+1).photo?.photoData)!) as Data
        let photo = SKPhoto.photoWithImage(UIImage(data:src)!)// add some UIImage
        images.append(photo)
        
        // 2. PhotoBrowser作成
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        present(browser, animated: true, completion: {})
    }
    
    @IBAction func photo_select(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backbutton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

