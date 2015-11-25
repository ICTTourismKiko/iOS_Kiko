//
//  setCardList.swift
//  kikou
//
//  Created by FUNAICT201311 on 2015/10/23.
//  Copyright © 2015年 FUNAICT201311. All rights reserved.
//

import UIKit

class setCardList2: UITableViewCell, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var introText: UILabel!
    
    var cardID = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(card :cardData) {
        
        self.title.text = card.title as String
        self.introText.text = card.introText as String
        // 表示する画像を設定する.
        let myImage = PhotoController().NSSImage(card.imageUrl!)
        self.iconImage.image = myImage
        self.iconImage.layer.cornerRadius = 10
        self.iconImage.layer.masksToBounds = true
        
        cardID = card.id+1
        
}

}
