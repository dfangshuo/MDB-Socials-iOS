//
//  InterestedUsersTableViewCell.swift
//  mdbSocials
//
//  Created by Fang on 3/2/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit

class InterestedUsersTableViewCell: UITableViewCell {

    var name: UILabel!

    override func awakeFromNib() {

        name = UILabel(frame: CGRect(x:10, y:25, width: 240, height:30))
        name.textColor = UIColor.black
        name.text = "My title goes here"
        name.font = UIFont.boldSystemFont(ofSize: 25)
        contentView.addSubview(name)
    
    }
    
}
