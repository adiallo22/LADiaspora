//
//  NotificationViewModel.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/11/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct NotificationViewModel {
    
    private let notification : Notification
    private let user : User
    
    let type : NotificationType
    
    var message : String {
        switch type {
        case .repost:
            return "reposted your post"
        case .like:
            return "liked your post"
        case .comment:
            return "commented your post"
        case .follow:
            return "followed you"
        }
    }
    
    var timestamp : String {
        let formatter = DateComponentsFormatter.init()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfYear]
        formatter.maximumUnitCount = 1
        let current = Date()
        return formatter.string(from: notification.timestamp, to: current)!
    }
    
    var imageURL : String {
        return user.profileURL
    }
    
    var username : String {
        return user.username
    }
    
    init(notification: Notification) {
        self.notification = notification
        self.type = notification.type
        self.user = notification.user
    }
    
}
