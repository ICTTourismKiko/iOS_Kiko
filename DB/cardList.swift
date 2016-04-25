//
//  cardList.swift
//  DB
//
//  Created by FUNAICT201311 on 2015/10/26.
//  Copyright © 2015年 project03A. All rights reserved.
//

import Foundation
import UIKit

class cardList: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigation: UINavigationBar!
    
    var cards:[cardData] = [cardData]()
    let set = setCardList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        let navBarImage = UIImage(named: "bar6.png") as UIImage?
        self.navigation.setBackgroundImage(navBarImage, forBarMetrics:. Default)
        
        self.setupLists()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, self.tableView.frame.width, self.tableView.frame.height))
        let image = UIImage(named: "tablebackground.png")
        imageView.image = image
        self.tableView.backgroundView = imageView
        
//        NSTimer.scheduledTimerWithTimeInterval(0.5,target:self,selector:Selector("reload"),
//            userInfo: nil, repeats: true);
        
        
        //NSTimer.scheduledTimerWithTimeInterval(0.5,target:self,selector:Selector("reload"), userInfo: nil, repeats: true);
    }
    
    override func viewWillAppear(animated: Bool) {
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
        let cell: setCardList = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! setCardList
        cell.setCell(cards[indexPath.row])
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func reload(){
        cards.removeAll()
        setupLists()
        tableView.reloadData()
    }
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

