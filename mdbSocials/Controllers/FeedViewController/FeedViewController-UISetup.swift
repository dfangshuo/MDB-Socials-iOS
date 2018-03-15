//
//  FeedViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import ChameleonFramework

extension FeedViewController {
    
    /*************************************************************************************************/
    /************************************ SIGN UP LAYOUT *********************************************/
    /*************************************************************************************************/
    func makeNavBar() {
        // NavBar
        let filler = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 25))
        filler.backgroundColor = Constants.appColor
        view.addSubview(filler)
        
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 15, width: view.frame.width, height: 30))
        navigationBar.backgroundColor = Constants.appColor
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "MDB Socials"
        
        
        let logout = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(logOut))
        let newPost = UIBarButtonItem(title: "New Event", style: .plain, target: self, action: #selector(toNewPost))
        
        navigationItem.leftBarButtonItem = logout
        navigationItem.rightBarButtonItem = newPost
        
        navigationBar.items = [navigationItem]
        self.view.addSubview(navigationBar)
        
    }
    
    func makeTable() {
        tableView = UITableView(frame: CGRect(x: 0, y:135, width: view.frame.width, height: view.frame.height-135),
                                style: UITableViewStyle.plain)
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "posts")
        tableView.clipsToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
}

