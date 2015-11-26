//
//  PagingCollectionViewCell.swift
//  DB
//
//  Created by 岩見建汰 on 2015/11/21.
//  Copyright © 2015年 project03A. All rights reserved.
//

import UIKit

class PagingCollectionViewCell: UICollectionViewCell {
    
    
//    @IBOutlet weak var photo: UIImageView!
//    @IBOutlet weak var TitleLabel: UILabel!
//    @IBOutlet weak var introLabel: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        introLabel.numberOfLines = 30
    }
    
}
