//
//  User.swift
//  FirebaseDemoMaster
//
//  Created by Vidya Ravikumar on 9/22/17.
//  Copyright © 2017 Vidya Ravikumar. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Users: Mappable {
    
    var name: String?
    var email: String?
    var id: String?
    var interestedEvents: [String] = []
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        interestedEvents   <- map["interestedEvents"]
        name        <- map["name"]
        email       <- map["email"]
        id          <- map["id"]
    }
    
//    static func getCurrentUser(withId: String, block: @escaping (Users) -> ()) {
//        APIClient.fetchUser(id: withId).then{(users) in
//            block(users)
//        }
//    }
    
    func addInterestedEvent(id: String) {
        //update local array
        interestedEvents.append(id)
        
        let childUpdates = ["interestedEvents": interestedEvents]
        APIClient.modifyUser(id: self.id!, childUpdates: childUpdates)
        
        // update database
//        let childUpdates = ["\(self.id!)/interestedEvents": interestedEvents]
//        APIClient.modifyUser(childUpdates: childUpdates)
    }
    
    func rmInterestedEvent(id: String) {
        interestedEvents.popLast()
        let childUpdates = ["interestedEvents": interestedEvents]
        APIClient.modifyUser(id: self.id!, childUpdates: childUpdates)
//        let childUpdates = ["\(self.id!)/interestedEvents": interestedEvents]
//        APIClient.modifyUser(childUpdates: childUpdates)

    }
    
    
}

