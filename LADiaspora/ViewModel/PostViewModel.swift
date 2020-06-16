//
//  PostViewModel.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/15/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct PostViewModel {
    
    var post : Post
    var user : User
    
    var profileURL : String {
        return user.profileURL
    }
    
    var username : String {
        return user.username
    }
    
    var fullname : String {
        return post.user.fullname
    }
    
    var timestamp : String {
        let formatter = DateComponentsFormatter.init()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfYear]
        formatter.maximumUnitCount = 1
        let current = Date()
        return formatter.string(from: post.timestamp, to: current)!
    }
    
    init(post: Post) {
        self.post = post
        self.user = post.user
    }
    
}
