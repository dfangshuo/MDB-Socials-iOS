//
//  DetailViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import ChameleonFramework
import MapKit

extension DetailViewController {
    
    func setupScroll() {
        scrollView = UIScrollView(frame:CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width + 520)
        view.addSubview(scrollView)
    }
    
    func setupView() {
        eventName = UILabel(frame: CGRect(x: 13, y: 60, width: view.frame.width - 20, height: 0.7 * 40))
        eventName.text = postObjs[indice].eventTitle!
        eventName.clipsToBounds = true
        eventName.adjustsFontSizeToFitWidth = true
        eventName.font = eventName.font!.withSize(38)
        scrollView.addSubview(eventName)
        
        posterName = UILabel(frame: CGRect(x: 13, y: 100, width: view.frame.width - 20, height: 0.7 * 40))
        posterName.text = "by \(postObjs[indice].poster!)"
        posterName.clipsToBounds = true
        posterName.adjustsFontSizeToFitWidth = true
        posterName.font = posterName.font!.withSize(25)
        posterName.textColor = HexColor("696969")
        scrollView.addSubview(posterName)
        
        eventImage = UIImageView(frame: CGRect(x: 13, y: 140, width: UIScreen.main.bounds.width - 25, height: UIScreen.main.bounds.width - 160))
        eventImage.image = #imageLiteral(resourceName: "MDB Cover")
        eventImage.layer.cornerRadius = 10
        eventImage.clipsToBounds = true
    
        APIClient.downloadPic(withURL:postObjs[indice].imageUrl!).then { img in
            self.eventImage.image = img
        }
        scrollView.addSubview(eventImage)
        
        
        dateTime = UILabel(frame: CGRect(x: 47, y: 410-100, width: self.view.frame.width-16, height: 0.7 * 20))
        dateTime.text = postObjs[indice].dateSelected!
        dateTime.clipsToBounds = true
        dateTime.textColor = HexColor("000000")
        dateTime.font = UIFont.boldSystemFont(ofSize: 20)
        scrollView.addSubview(dateTime)
        
        interestLvl = UIButton(frame: CGRect(x: 2, y: 395-95, width: self.view.frame.width-16, height: 0.7 * 100))
        interestLvl.setTitle("People Interested: \(postObjs[indice].interestedUsers.count)" , for: .normal)
        interestLvl.titleLabel!.font = UIFont.boldSystemFont(ofSize: 15)
        interestLvl.addTarget(self, action: #selector(openInterestedUsersModalView), for: .touchUpInside)
        interestLvl.setTitleColor(HexColor("696969"), for: .normal)
        scrollView.addSubview(interestLvl)
        
        loc = MKMapView(frame:CGRect(x: 13, y: 740-186, width: UIScreen.main.bounds.width - 25, height: UIScreen.main.bounds.width - 170))
        loc.layer.cornerRadius = 10
        loc.mapType = .standard
        loc.clipsToBounds = true
        scrollView.addSubview(loc)
        addAnnotationToMap()
        
        details = UILabel(frame: CGRect(x: 8, y: 465-110, width: self.view.frame.width-16, height: 0.7 * 150))
        details.layoutIfNeeded()
        details.text = postObjs[indice].eventDescribed!
        details.layer.borderColor = Constants.appColor.cgColor
        details.layer.borderWidth = 1.5
        details.layer.cornerRadius = 10
        details.layer.masksToBounds = true
        details.clipsToBounds = true
        details.textColor = HexColor("696969")
        scrollView.addSubview(details)
        
        interestButton = UIButton(frame: CGRect(x: 10, y: 630-160, width: UIScreen.main.bounds.width - 20, height: 0.7 * 45))
        interestButton.layoutIfNeeded()
        
        if postObjs[indice].interestedUsers.contains(FirebaseHelper.currUserID()) {
            interestButton.backgroundColor = Constants.appGreen
            interestButton.setTitle("i'm going ", for: .normal)
        } else {
            interestButton.setTitle("I'M INTERESTED", for: .normal)
            interestButton.backgroundColor = Constants.appRed
        }
        
        interestButton.addTarget(self, action: #selector(interestShown), for: .touchUpInside)
        interestButton.layer.cornerRadius = 10
        scrollView.addSubview(interestButton)
        
        getMeThere = UIButton(frame: CGRect(x: 10, y: 685-180, width: UIScreen.main.bounds.width - 20, height: 0.7 * 45))
        getMeThere.addTarget(self, action: #selector(openAMaps), for: .touchUpInside)
        getMeThere.setTitle("GET ME THERE G", for: .normal)
        getMeThere.backgroundColor = Constants.appColor
        getMeThere.layer.cornerRadius = 10
        scrollView.addSubview(getMeThere)
        
        weather = UILabel(frame: CGRect(x: 32, y: UIScreen.main.bounds.width + 590-186, width: view.frame.width-16, height: 20))
        weather.clipsToBounds = true
        weather.textColor = HexColor("000000")
        weather.font = UIFont.boldSystemFont(ofSize: 0.7*20)
        scrollView.addSubview(weather)
        
        cloudStatus = UILabel(frame: CGRect(x: 112, y: UIScreen.main.bounds.width + 615-186, width: view.frame.width-16, height: 0.7 * 20))
        cloudStatus.clipsToBounds = true
        cloudStatus.textColor = HexColor("696969")
        cloudStatus.font = UIFont.boldSystemFont(ofSize: 0.7*16)
        scrollView.addSubview(cloudStatus)
 
    }
    
    func makeNavBar() {
        // NavBar
        let filler = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0.7 * 25))
        filler.backgroundColor = Constants.appColor
        view.addSubview(filler)
        
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 15, width: view.frame.width, height: 0.7 * 30))
        navigationBar.backgroundColor = Constants.appColor
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "MDB Socials"
        
        
        let cancel = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(backBack))
        
        navigationItem.leftBarButtonItem = cancel
        
        navigationBar.items = [navigationItem]
        self.view.addSubview(navigationBar)
        
    }
}

