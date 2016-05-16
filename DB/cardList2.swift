//
//  cardList.swift
//  DB
//
//  Created by FUNAICT201311 on 2015/10/26.
//  Copyright © 2015年 project03A. All rights reserved.
//

import Foundation
import UIKit

class cardList2: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var navi: UINavigationBar!
    
    var cards:[cardData] = [cardData]()
    let set = setCardList2()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navi.setBackgroundImage(navBarImage, forBarMetrics:. Default)
        
        self.setupLists()
        
        self.tableView2.delegate = self
        self.tableView2.dataSource = self
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, self.tableView2.frame.width, self.tableView2.frame.height))
        let image = UIImage(named: "tablebackground.png")
        imageView.image = image
        self.tableView2.backgroundView = imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLists() {
        for i in 1...DB().cardListSize(){
            let card = DB().getCard(i)
            let f1 = cardData(title: card.cardText!.title,
                introText: card.cardText!.text, imageUrl: NSData(data: (DB().getCard(i).photo?.photoData)!),id: i-1,flag:DB().getFlagStatement(i))
            cards.append(f1)
        }
    }
    
    
    // functions needed to be implemented
    // for table view
    
    // セクション数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // セクションの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell: setCardList2 = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! setCardList2
        cell.setCell(cards[indexPath.row])
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = UIColor.clearColor()
        return cell
    }
    @IBAction func photo_select(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func backbutton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

