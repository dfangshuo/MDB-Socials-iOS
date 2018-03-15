//
//  FeedTableViewCell.swift
//  mdbSocials
//
//  Created by Fang on 2/21/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    var img: UIImageView!
    var name: UILabel!
    var num: UILabel!
    var descrip: UILabel!
    var poster: UILabel!
    
    override func awakeFromNib() {
        img = UIImageView(frame: CGRect(x:20, y:15, width: 0.7*120, height: 0.7*120))
        img.image = #imageLiteral(resourceName: "MDB Cover")
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        img.layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(img) //remember to add UI elements to the contentView not the cell itself
        
        name = UILabel(frame: CGRect(x:167-40, y:18*0.75, width: 0.7*240, height: 0.7*30))
        name.textColor = UIColor.black
        name.font = UIFont.boldSystemFont(ofSize: 0.7*25)
        contentView.addSubview(name)
        
        num = UILabel(frame: CGRect(x:167-40, y:84*0.75, width: 0.7*300, height: 0.7*30))
        num.textColor = UIColor.darkGray
        contentView.addSubview(num)
        
        descrip = UILabel(frame: CGRect(x:167-40, y:114*0.75, width: 0.7*300, height: 0.7*30))
        descrip.text = "is/are interested!"
        descrip.textColor = UIColor.darkGray
        contentView.addSubview(descrip)
        
        
        poster = UILabel(frame: CGRect(x:167-40, y:51*0.75, width: 0.7*240, height: 0.7*30))
        poster.textColor = UIColor.darkGray
        poster.font = UIFont.boldSystemFont(ofSize: 0.7*20)
        contentView.addSubview(poster)
    }
}
