//
//  NewSocialViewController-Delegate.swift
//  mdbSocials
//
//  Created by Fang on 3/1/18.
//  Copyright © 2018 fang. All rights reserved.
//

import Foundation
import UIKit

extension NewSocialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        addImage.removeFromSuperview()
        takePicture.removeFromSuperview()
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        eventImageView.contentMode = .scaleAspectFit
        eventImageView.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
