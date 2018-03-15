//
//  EventsViewControllerTableViewCell.swift
//  mdbSocials
//
//  Created by Fang on 3/2/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    var events: UILabel!
    
    override func awakeFromNib() {
        events = UILabel(frame: CGRect(x:40, y:18, width: 240, height:30))
        events.textColor = UIColor.black
        events.font = UIFont.boldSystemFont(ofSize: 0.7*25)
        contentView.addSubview(events)
    }
    
}
