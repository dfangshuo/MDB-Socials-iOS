//
//  EventsViewController.swift
//  mdbSocials
//
//  Created by Fang on 3/2/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import Dispatch

class EventsViewController: UIViewController {

    var interestedEventz: [String] = []
    var tableView: UITableView!
    var head: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBar()
        makeTable()
        makeTable()
        self.tabBarItem.title = "Events I'm going to"
    }

    func makeTable() {
        head = UILabel(frame: CGRect(x: 40, y: 70, width: view.frame.width - 20, height: 40))
        head.text = "Events I'm going for"
        head.font = head.font!.withSize(0.7*38)
        view.addSubview(head)
        
        tableView = UITableView(frame: CGRect(x: 0, y:135, width: view.frame.width, height: view.frame.height-135),
                                style: UITableViewStyle.plain)
        tableView.register(EventsTableViewCell.self, forCellReuseIdentifier: "events")
        tableView.clipsToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
    func makeNavBar() {
        // NavBar
        let filler = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 25))
        filler.backgroundColor = Constants.appColor
        view.addSubview(filler)
        
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 15, width: view.frame.width, height: 30))
        navigationBar.backgroundColor = Constants.appColor
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "MDB Socials"
        
        navigationBar.items = [navigationItem]
        self.view.addSubview(navigationBar)
        
    }
 
}
