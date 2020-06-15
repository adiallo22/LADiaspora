//
//  Post.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/15/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct Post {
    
    let caption : String
    let likes : Int
    let uid : String
    var timestamp : Date!
    let repost : Int
    let postID : String
    
    init(uid: String, values: [String:Any]) {
        self.uid = uid
        self.caption = values["caption"] as? String ?? ""
        self.likes = values["likes"] as? Int ?? 0
        self.repost = values["repost"] as? Int ?? 0
        self.postID = values["postID"] as? String ?? ""
        if let timestamp = values["timestamp"] as? Double {
            self.timestamp = Date.init(timeIntervalSince1970: timestamp)
        }
    }
    
}
