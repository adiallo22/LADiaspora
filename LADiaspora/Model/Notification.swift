//
//  Notification.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/8/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct Notification {
    
    var postID : String?
    let post : Post?
    var timestamp : Date!
    var user : User
    var type : NotificationType!
    
    init(user: User, post: Post?, value: [String:Any]) {
        self.user = user
        self.post = post
        if let postID = value["postID"] as? String {
            self.postID = postID
        }
        if let timestamp = value["timestamp"] as? Double {
            self.timestamp = Date.init(timeIntervalSince1970: timestamp)
        }
        if let type = value["type"] as? Int {
            self.type = NotificationType(rawValue: type)
        }
    }
    
}

enum NotificationType : Int {
    case repost
    case like
    case comment
    case follow
}
