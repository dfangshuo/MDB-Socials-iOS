//
//  FeedViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import ChameleonFramework

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDir.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "posts", for: indexPath)
            as! FeedTableViewCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        APIClient.downloadPic(withURL:postDir[indexPath.row].imageUrl!).then { img in
            cell.img.image = img
            }
        
        cell.name.text = postDir[indexPath.row].eventTitle
        cell.num.text = "\(String(describing: postDir[indexPath.row].interestedUsers.count)) person(s)"
        cell.poster.text = postDir[indexPath.row].poster
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        
        self.performSegue(withIdentifier: "moreDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.8*160
    }
}

