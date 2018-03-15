//
//  imageHelper.swift
//  mdbSocials
//
//  Created by Fang on 2/22/18.
//  Copyright © 2018 fang. All rights reserved.
//

import Foundation
import PromiseKit
import FirebaseAuth

class FirebaseHelper {
    
    static func getUserName(id: String) -> Promise<String> {
        return Promise { fulfill, reject in
            var username: String!
            APIClient.fetchUser(id: id).then{ (User) in
                username =  User.name
                }.then{_ -> Void in
                    log.info("Retrieved Current User Name \(username) from Firebase")
                    fulfill(username)
            }
        }
    }
    static func makePostPicOptional(title: String, postText: String, poster: String, posterId: String, num: [String], timePicked: String, img: UIImage?) {
        APIClient.createNewPost(title: title, postText: postText, poster: poster, imageUrl: "nil", posterId: posterId, num: num, timePicked: timePicked).then{(key) in
            APIClient.postImageInStorage(img: img, imageId: key)
        }
        
    }
    
    static func makeUserPicOptional(userModel: Users ,email: String, password: String, dictOfInfo: [String:Any], successAction: @escaping () -> (), failureAction: @escaping () -> ()) -> Promise<String> {
        return Promise {fulfill, reject in
            let name = dictOfInfo["name"] as! String
            let username = dictOfInfo["username"] as!String
            var userId: String!
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil && user != nil {
                    
                    APIClient.createNewUser(id: (user?.uid)!, name: name, username: username, imageURL: "nil")
                    userModel.name = name
                    userId = (user?.uid)!
                    userModel.id = userId
                    
                    successAction()
                    fulfill(userId)
                }
                else {
                    log.error("Error Creating User: \(error.debugDescription)")
                    failureAction()
                }
            })
        }
    }
           
    static func currUser() -> User? {
        return Auth.auth().currentUser
    }
    
    static func currUserID() -> String {
        return currUser()!.uid
    }
}



