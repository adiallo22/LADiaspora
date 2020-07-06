//
//  PostViewModel.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/15/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation
import UIKit.UIImage
import UIKit.UIColor

struct PostViewModel {
    
    private var post : Post
    private var user : User
    
    var profileURL : String {
        return user.profileURL
    }
    
    var username : String {
        return user.username
    }
    
    var fullname : String {
        return post.user.fullname
    }
    
    var caption : String {
        return post.caption
    }
    
    var likeImage : UIImage {
        let imageName = post.isLiked ? "heart.fill" : "heart"
        return UIImage.init(systemName: imageName)!
    }
    
    var likeColor : UIColor {
        return post.isLiked ? .red : .black
    }
    
    var timestamp : String {
        let formatter = DateComponentsFormatter.init()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfYear]
        formatter.maximumUnitCount = 1
        let current = Date()
        return formatter.string(from: post.timestamp, to: current)!
    }
    
    var secondTimestamp : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a  -  MM/dd/yyyy"
        return formatter.string(from: post.timestamp)
    }
    
    var numberOfLikes : String {
        return "\(post.likes) Likes"
    }
    
    var numberOfRepost : String {
        return "\(post.repost) Reposts"
    }
    
    init(post: Post) {
        self.post = post
        self.user = post.user
    }
    
}
