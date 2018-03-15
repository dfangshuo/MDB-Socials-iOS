//
//  NewSocialViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import ChameleonFramework
import LocationPicker
import MapKit

class NewSocialViewController: UIViewController, UITextViewDelegate {
    
    // event entry parameters
    var eventName: UITextField!
    var descrip: UITextView!
    var makeEventButton: UIButton!
    var addImage: UIButton!
    var takePicture: UIButton!
    var datePicker: UIDatePicker!
    var locPicker: UIButton!

    var cancel: UIButton!
    var scrollView: UIScrollView!

    // event storage parameters
    var eventCalled: String!
    var dateSelected: String!
    var eventDescribed: String!
    
    // temp date storage
    var tempDate: String!
    var eventImageView: UIImageView!
    let picker = UIImagePickerController()
    var longLat: CLLocationCoordinate2D!
    var lat: Double!
    var long: Double!
    
    var postingUser: Users!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(SignupViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        nc.addObserver(self, selector: #selector(SignupViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        nc.addObserver(self, selector: #selector(makeEventError), name: NSNotification.Name(rawValue: "noName"), object: nil)
        nc.addObserver(self, selector: #selector(makeEventError), name: NSNotification.Name(rawValue: "noDate"), object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(swipeGoBack))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        setupScroll()
        setUpView()
        setUpEventView()
        makeNavBar()
    }
    
    @objc func eventMade() {
        let notif = NotificationCenter.default
        if (eventName.text! != "") {
             eventCalled = eventName.text!
            
            // format description data
            if descrip.text == "What in the world is this???" {
                eventDescribed = ""
            } else {
                eventDescribed = descrip.text!
            }
            
            if tempDate == nil {
                notif.post(name: NSNotification.Name(rawValue: "noDate"), object: nil, userInfo: ["errorMsg": "Is this really the time you want?"])
//                Utils.throwError(info: "Is this really the time you want?", vc: self)
            } else {
                dateSelected  = tempDate!
                FirebaseHelper.makePostPicOptional(title: self.eventCalled, postText: self.eventDescribed, poster: self.postingUser.name!, posterId: self.postingUser.id!, num: [FirebaseHelper.currUserID()], timePicked: self.dateSelected, img: eventImageView.image)
            }
        } else {
            notif.post(name: NSNotification.Name(rawValue: "noName"), object: nil, userInfo: ["errorMsg": "Please name this event"])
//            Utils.throwError(info: "Please name this event", vc: self)
        }
        self.dismiss(animated: true, completion: {})
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        // Apply date format
        tempDate = dateFormatter.string(from: sender.date)
        
        print("Selected value \(tempDate!)")
    }

    @objc func goBack() {
        print("Cancelled")
        self.dismiss(animated: true, completion: {})
    }
    
    @objc func swipeGoBack() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: {})
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == Constants.appTxt {
            textView.text = nil
            textView.textColor = HexColor("000000")!
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What in the world is this???"
            textView.font = textView.font?.withSize(20)
            textView.textColor = Constants.appTxt
        }
    }
    
    @objc func pickImage(sender: UIButton!) {
            picker.delegate = self
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
    
    @objc func takePic() {
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .camera
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc func pickLoc() {
        
        let locationPicker = LocationPickerViewController()
        locationPicker.showCurrentLocationButton = true // default: true
        locationPicker.currentLocationButtonBackground = Constants.appColor
        locationPicker.mapType = .standard // default: .Hybrid
        locationPicker.searchBarPlaceholder = "Where the party at" // default: "Search or enter an address"
        locationPicker.resultRegionDistance = 500 // default: 600
        
        locationPicker.completion = { location in
            self.longLat = location?.coordinate
            self.long = self.longLat.longitude
            self.lat = self.longLat.latitude
            let newTitle = String(self.long) + ", " + String(self.lat)
            self.locPicker.setTitle(newTitle, for: .normal)

            print(self.longLat)

        }
        
        self.present(locationPicker, animated: true) {
            print("Selecting location")
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func makeEventError(_ notification: Notification) {
        let alert = UIAlertController(title: "\(notification.userInfo!["errorMsg"]!)", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
