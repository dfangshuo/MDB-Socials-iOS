//
//  NewSocialViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import ChameleonFramework

extension NewSocialViewController {
    
    func setupScroll() {
        scrollView = UIScrollView(frame:CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width + 450)
        view.addSubview(scrollView)
    }
    
    func setUpView() {
        
        eventName = UITextField(frame: CGRect(x: 40, y: 65, width: UIScreen.main.bounds.width - 85, height: 0.7 * 40))
        eventName.placeholder = "New Event"
        eventName.clipsToBounds = true
        eventName.adjustsFontSizeToFitWidth = true
        eventName.becomeFirstResponder()
        eventName.font = eventName.font!.withSize(35)
        scrollView.addSubview(eventName)
        
        descrip = UITextView(frame: CGRect(x: 8, y: 445-87+40+57, width: self.view.frame.width-16, height: 0.7 * 90 * 2))
        descrip.delegate = self
//        descrip.becomeFirstResponder()
        descrip.selectedTextRange = descrip.textRange(from: descrip.beginningOfDocument, to: descrip.beginningOfDocument)
        descrip.layoutIfNeeded()
        descrip.layer.borderColor = Constants.appColor.cgColor
        descrip.layer.borderWidth = 1.5
        descrip.layer.cornerRadius = 10
        descrip.layer.masksToBounds = true
        descrip.clipsToBounds = true
        descrip.textColor = HexColor("000000")!
        scrollView.addSubview(descrip)
        
        datePicker = UIDatePicker(frame: CGRect(x: 10, y: 350-77+55,  width: UIScreen.main.bounds.width - 16, height: 0.7 * 115 * 1.5))
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = HexColor("FFFFFF")!
        
        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        // Add DataPicker to the view
        scrollView.addSubview(datePicker)
        
        locPicker = UIButton(frame: CGRect(x: 10, y: 515-87+63+45+57, width: UIScreen.main.bounds.width - 20, height: 0.9 * 45))
        locPicker.layoutIfNeeded()
        locPicker.setTitle("Where might you want this to be?", for: .normal)
        locPicker.layer.cornerRadius = 10
        locPicker.backgroundColor = Constants.appTxt
        locPicker.addTarget(self, action: #selector(pickLoc), for: .touchUpInside)
        scrollView.addSubview(locPicker)
        
        makeEventButton = UIButton(frame: CGRect(x: 10, y: 0.8 * UIScreen.main.bounds.height+71+55+62, width: UIScreen.main.bounds.width - 20, height: 0.85 * 45))
        makeEventButton.layoutIfNeeded()
        makeEventButton.setTitle("Make Event", for: .normal)
        makeEventButton.layer.cornerRadius = 10
        makeEventButton.addTarget(self, action: #selector(eventMade), for: .touchUpInside)
        makeEventButton.backgroundColor = Constants.appColor
        scrollView.addSubview(makeEventButton)
        
//        cancel = UIButton(frame:CGRect(x: (view.frame.width - 125)/2, y: 0.85*575 + 213, width: 125, height: 0.7 * 30))
//        cancel.setTitleColor(Constants.appColor, for: .normal)
//        cancel.setTitle("back", for: .normal)
//        cancel.addTarget(self, action: #selector(goBack), for: .touchUpInside)
//        scrollView.addSubview(cancel)

    }
    
    func setUpEventView() {
        eventImageView = UIImageView(frame: CGRect(x: 40, y: 97, width: UIScreen.main.bounds.width - 85, height: UIScreen.main.bounds.width - 85))
        eventImageView.clipsToBounds = true
        scrollView.addSubview(eventImageView)
        
        takePicture = UIButton(frame: CGRect(x:(view.frame.width-75)/2 - 45, y: 170-5, width: 75, height: 75))
        takePicture.setTitle("Camera", for: .normal)
        takePicture.clipsToBounds = true
        takePicture.addTarget(self, action: #selector(takePic), for: .touchUpInside)
        takePicture.layer.cornerRadius = 10
        takePicture.backgroundColor = Constants.appColor
        scrollView.addSubview(takePicture)
        
        addImage = UIButton(frame: CGRect(x:(view.frame.width-75)/2 + 45, y: 170-5, width: 75, height: 75))
        addImage.setTitle("Roll", for: .normal)
        addImage.clipsToBounds = true
        addImage.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        addImage.layer.cornerRadius = 10
        addImage.backgroundColor = Constants.appTxt
        scrollView.addSubview(addImage)
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
        
        
        let back = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(goBack))
        
        navigationItem.leftBarButtonItem = back
        
        navigationBar.items = [navigationItem]
        self.view.addSubview(navigationBar)
        
    }
}

