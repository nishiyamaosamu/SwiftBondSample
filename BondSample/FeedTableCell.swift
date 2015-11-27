//
//  FeedTableCell.swift
//  BondSample
//
//  Created by Osamu Nishiyama on 2015/11/27.
//  Copyright © 2015年 ever sense. All rights reserved.
//

import UIKit
import Bond

class FeedTableCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        
        bnd_bag.dispose()
    }
}
