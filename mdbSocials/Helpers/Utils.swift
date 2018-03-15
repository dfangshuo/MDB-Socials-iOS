//
//  Utils.swift
//  mdbSocials
//
//  Created by Fang on 2/28/18.
//  Copyright © 2018 fang. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func throwError(info: String, vc: UIViewController) {
        let alert = UIAlertController(title: "\(info)", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
