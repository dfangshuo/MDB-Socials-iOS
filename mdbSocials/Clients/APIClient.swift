//
//  APIClient.swift
//  FirebaseDemoMaster
//
//  Created by Sahil Lamba on 2/16/18.
//  Copyright © 2018 Vidya Ravikumar. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftyJSON
import ObjectMapper
import PromiseKit
import Haneke

class APIClient {
 
    /**********************************************************/
    /****************** MAKE POSTS ***************************/
    /**********************************************************/
    
    static func fetchPosts(withBlock: @escaping (Post) -> ()) {
                    //TODO: Implement a method to fetch posts with Firebase!
                    print("fetchPosts was called")
                    let _ = Alamofire.request("http://mdbsocials-restapi.herokuapp.com/posts").responseJSON { response in
                        if let json = response.result.value {
                            let json2 = JSON(json)
                            for each in json2 {
                                print("PRE RESULT")
                                print(each.1)
                                if let result = (each.1).dictionaryObject {
                                    print("POST RESULT")
                                    print(result)
                                    if let post = Post(JSON: result) {
                                        withBlock(post)
                                }
                            }
                        }
                        log.info("Successfully Fetched Posts from Firebase to load Feed")
                        }
                        else {
                            let nc = NotificationCenter.default
                            nc.post(name: NSNotification.Name(rawValue: "feedNotLoaded"), object: nil, userInfo: ["errorMsg": "ERROR: Feed Not Loaded", "errorDetail": "Check Network Connection"])
                            log.error("NETWORK ERROR: Failed to fetch Posts from Firebase to load Feed")
                        }
        }
    }
    
    // no promises
//    static func fetchPosts(withBlock: @escaping (Post) -> ()) {
//        //TODO: Implement a method to fetch posts with Firebase!
//        let ref = Database.database().reference()
//        ref.child("Posts").observe(.childAdded, with: { (snapshot) in
//
//            let json = JSON(snapshot.value)
//            print("THIS IS THE JSON")
//            print(json)
//            if var result = json.dictionaryObject {
//                print("THIS IS THE RESULT")
//                print(result)
//                result["key"] = snapshot.key
//                if let post = Post(JSON: result) {
//                    log.info("Successfully Fetched Posts from Firebase to load Feed")
//
//        //alamoire call to my rest api
//        // converts json to post object
//        withBlock(post)
//                }
//            }
//        })
//    }
    
    static func fetchPost(id: String) -> Promise<Post> {
        print("fetch ONE POST was called")
        var count = 0
        return Promise {fulfill, reject in
            let _ = Alamofire.request("http://mdbsocials-restapi.herokuapp.com/posts/\(id)").responseJSON { response in
                let json = JSON(response.result.value)
                print("LOOKZ HERE \(count )")
                print(json)
                if var result = json.dictionaryObject {
//                    result["id"] = id
                    print("LOOK HERE 2")
                    print(result)
                    print(result["interestedUsers"])

                    if let post = Post(JSON: result) {
                        print("LOOK HERE 3")
                        log.info("Successfully Fetched \(id) from Firebase to setup Events")
                        fulfill(post)
                        count += 1

                    }
                }
//                count += 1
            }
        }
    }
    
//    static func fetchPost(id: String) -> Promise<Post> {
//        return Promise {fulfill, reject in
//            let ref = Database.database().reference()
//            ref.child("Posts").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
//                let json = JSON(snapshot.value)
//                if var result = json.dictionaryObject {
//                    result["_key"] = snapshot.key
//                    if let post = Post(JSON: result) {
////                        print("I MADE THE POST")
////                        print(post.eventTitle)
//                        log.info("Successfully Fetched Posts from Firebase to setup Events Tab")
//                        fulfill(post)
//                    }
//                }
//            })
//        }
//    }

//    static func createNewPost(postsRef: DatabaseReference, key: String, title: String, postText: String, poster: String,
//                              imageUrl: String, posterId: String, num: [String], timePicked: String)
//        // ONE: take in a bunch of arguments, key-value pairs of your desired JSON Object
//    {
//
//        // TWO: put these key-value pairs in a dictionary which you then...
//        let newPost = ["title" : title, "text": postText, "poster": poster, "imageUrl": imageUrl, "posterId": posterId, "num": num, "timePicked": timePicked] as [String : Any]
//        //THREE: upload into FB
//        let childUpdates = ["/\(key)/": newPost]
//        postsRef.updateChildValues(childUpdates)
//        log.info("\(title) with reference \(postsRef) successfully created!")
//
//    }
    
    
//    static func createNewPost(title: String, postText: String, poster: String,
//                              imageUrl: String, posterId: String, num: [String], timePicked: String) -> Promise<String> {
//        return Promise {fulfill, reject in
//            let newPost = ["title" : title, "text": postText, "poster": poster, "imageUrl": imageUrl, "posterId": posterId, "num": num, "timePicked": timePicked] as [String : Any]
//
//            Alamofire.request("http://mdbsocials-restapi.herokuapp.com/posts", method: .post, parameters:
//                newPost,encoding: JSONEncoding.default, headers: nil).responseString {
//                    response in
//                    switch response.result {
//                    case .success:
//                        log.info("Successfully created new post")
//                        print(response)
//
//                        break
//                    case .failure(let error):
//                        print("HELP THERES ERROR")
//                        log.error(error)
//                        print(error)
//                    }
//            }
//
////            fulfill(key)
//        }
//    }
    
    static func createNewPost(title: String, postText: String, poster: String,
                              imageUrl: String, posterId: String, num: [String], timePicked: String) -> Promise<String> {
        // ONE: take in a bunch of arguments, key-value pairs of your desired JSON Object
        return Promise {fulfill, reject in
            let postsRef = Database.database().reference().child("Posts")
            let key = postsRef.childByAutoId().key
            
            // TWO: put these key-value pairs in a dictionary which you then...
            let newPost = ["title" : title, "text": postText, "poster": poster, "imageUrl": imageUrl, "posterId": posterId, "num": num, "timePicked": timePicked] as [String : Any]
            //THREE: upload into FB
            let childUpdates = ["/\(key)/": newPost]
            postsRef.updateChildValues(childUpdates)
            log.info("\(title) with reference \(postsRef) successfully created!")
            fulfill(key)
        }
    }
    
//    static func makePostPicOptional(title: String, postText: String, poster: String, posterId: String, num: [String], timePicked: String, img: UIImage?) {
//
//        let postsRef = Database.database().reference().child("Posts")
//        let key = postsRef.childByAutoId().key
//        var inURL = "nil"
//
//        if img == nil {
//            APIClient.createNewPost(postsRef: postsRef, key: key, title: title, postText: postText, poster: poster, imageUrl: inURL, posterId: posterId, num: num, timePicked: timePicked)
//        } else {
//            let storageRef = Storage.storage().reference()
//            let data = UIImageJPEGRepresentation(img!, 1.0)
//
//            // Create a reference to the file you want to upload
//            let events = storageRef.child(key)
//            let metadata = StorageMetadata()
//            metadata.contentType = "image/jpeg"
//
//            let uploadTask = events.putData(data!, metadata: nil) { (metadata, error) in
//                guard let metadata = metadata else {
//                    return
//                }
//                // Metadata contains file metadata such as size, content-type, and download URL.
//                inURL = (metadata.downloadURL()?.absoluteString)!
//                APIClient.createNewPost(postsRef: postsRef, key: key, title: title, postText: postText, poster: poster, imageUrl: inURL, posterId: posterId, num: num, timePicked: timePicked)
//            }
//        }
//    }
    
    static func modify(id: String, childUpdates: [String : Any]) {
        Alamofire.request("http://mdbsocials-restapi.herokuapp.com/posts/\(id)", method: .patch, parameters:
            childUpdates,encoding: JSONEncoding.default, headers: nil).responseString {
            response in
            switch response.result {
            case .success:
                log.info("Successfully changed number of interested users")
                print(response)
                
                break
            case .failure(let error):
                log.error(error)
                print(error)
            }
        }
    }

//    static func modify(childUpdates: [String : Any]) {
//
//
//        let ref = Database.database().reference().child("Posts")
//        ref.updateChildValues(childUpdates)
//    }
    
    
    
    /**********************************************************/
    /******************** USER FNS ***************************/
    /**********************************************************/
    
//    static func fetchUser(id: String) -> Promise<Users> {
//        return Promise {fulfill, reject in
//            let ref = Database.database().reference()
//            ref.child("Users").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
//                let json = JSON(snapshot.value)
//                if var result = json.dictionaryObject {
//                    result["id"] = snapshot.key
//                    if let user = Users(JSON: result) {
//                        log.info("Successfully Fetched User from Firebase")
//                        fulfill(user)
//                    }
//                }
//            })
//        }
//    }
    
    static func fetchUser(id: String) -> Promise<Users> {
        return Promise {fulfill, reject in
            let _ = Alamofire.request("http://mdbsocials-restapi.herokuapp.com/user/\(id)").responseJSON { response in
                let json = JSON(response.result.value!)
                if let result = json.dictionaryObject {
//                    print("THIS IS THE USER FETCHED")
//                    print(result)
                    if let user = Users(JSON: result) {
                        log.info("Successfully Fetched User from Firebase to setup Events")
                        fulfill(user)
                    }
                }
            }
        }
    }
    
//    static func createNewUser(id: String, name: String, username: String, imageURL: String) {
//        let newUser = ["name": name, "username": username, "imageURL": imageURL, "id": id] as [String: Any]
//
//        Alamofire.request("http://mdbsocials-restapi.herokuapp.com/user/\(id)", method: .post, parameters:
//            newUser,encoding: JSONEncoding.default, headers: nil).responseString {
//                response in
//                switch response.result {
//                case .success:
//                    print(response)
//                    log.info("Successfull created new users")
//
//                    break
//                case .failure(let error):
//                    log.error(error)
//                }
//        }
//
//        log.info("User \(name) with reference \(id) successfully created!")
//
//    }
    
    
    static func createNewUser(id: String, name: String, username: String, imageURL: String) {
        let usersRef = Database.database().reference().child("Users")
        let newUser = ["name": name, "username": username, "imageURL": imageURL, "id": id]
        let childUpdates = ["/\(id)/": newUser]
        usersRef.updateChildValues(childUpdates)
    }
    
    static func modifyUser(id: String, childUpdates: [String : Any]) {
        Alamofire.request("http://mdbsocials-restapi.herokuapp.com/user/\(id)", method: .patch, parameters:
            childUpdates,encoding: JSONEncoding.default, headers: nil).responseString {
                response in
                switch response.result {
                case .success:
                    print(response)
                    log.info("Successfull changed number of interested Events")

                    break
                case .failure(let error):
                    log.error(error)
                }
        }
    }
    
    
    /**********************************************************/
    /********************  IMAGE FNS ***************************/
    /**********************************************************/
    
//    static func uploadImg(key: String, imgView: UIImageView) {
//        let storageRef = Storage.storage().reference()
//        let data = UIImageJPEGRepresentation(imgView.image!, 1.0)
//
//        // Create a reference to the file you want to upload
//        let events = storageRef.child(key)
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"
//
//        let uploadTask = events.putData(data!, metadata: nil) { (metadata, error) in
//            guard let metadata = metadata else {
//                log.error("Failed to upload Img: \(error.debugDescription)")
//                return
//            }
//        }
//    }
    
    static func downloadPic(withURL: String) -> Promise<UIImage> {
        return Promise {fulfill, reject in
            let cache = Shared.imageCache
            if let imageURL = URL(string: withURL) {
                cache.fetch(URL: imageURL as URL).onSuccess({img in
                    log.info("Picture with URL \(withURL) successfully fetched!")
                    fulfill(img)
                })
            }
        }
    }
    
    static func postImageInStorage(img: UIImage?, imageId: String) {
        if img != nil {
            
            let postsRef = Database.database().reference().child("Posts")
            let key = postsRef.childByAutoId().key
            
            let storageRef = Storage.storage().reference()
            let data = UIImageJPEGRepresentation(img!, 1.0)
            
            let events = storageRef.child(key)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let uploadTask = events.putData(data!, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    log.error(error?.localizedDescription)
                    return
                }
                let inURL = (metadata.downloadURL()?.absoluteString)!
                let newURL = ["\(imageId)/imageUrl": inURL]
                postsRef.updateChildValues(newURL)
                log.info("Image with reference successfully uploaded to Firebase by user with reference \(imageId)")
            }
        }
    }
    
    static func putImageInStorage(img: UIImage?, userId: String) {
        if img != nil {
            
            let usersRef = Database.database().reference().child("Users")
            let key = usersRef.childByAutoId().key
            
            let storageRef = Storage.storage().reference()
            let data = UIImageJPEGRepresentation(img!, 1.0)
            
            let events = storageRef.child(key)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let uploadTask = events.putData(data!, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    log.error(error?.localizedDescription)
                    return
                }
                let inURL = (metadata.downloadURL()?.absoluteString)!
                let newURL = ["\(userId)/imageURL": inURL]
                usersRef.updateChildValues(newURL)
                log.info("Image with reference successfully uploaded to Firebase by user with reference \(userId)")
            }
        }
    }
}



