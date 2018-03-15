//
//  SignupViewController-.swift
//  mdbSocials
//
//  Created by Fang on 3/1/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit

extension SignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Delegates
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let nc: NotificationCenter = NotificationCenter.default
//        nc.addObserver(self, selector: #selector(ppReceived(_ :)), name: NSNotification.Name(rawValue: "profilePicture"), object: nil)
//
//        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        ppDisplay.contentMode = .scaleAspectFit
//        ppDisplay.image = chosenImage
//        dismiss(animated:true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        addPP.removeFromSuperview()
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        ppDisplay.contentMode = .scaleAspectFit
        ppDisplay.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
//    @objc func ppReceived(_ notification: Notification) {
//        print("Notification received!")
//        addPP.removeFromSuperview()
//    }
}

