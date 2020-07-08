//
//  NotificationService.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/8/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Firebase
private let notificationRef = Constants.References.db.child("notifications")

struct NotificationService {
    
    static let shared = NotificationService()
    
    func uploadNotification(withType type: NotificationType, post: Post?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var value : [String:Any] = [
            "uid":uid,
            "timestamp": Int(NSDate().timeIntervalSince1970),
            "type": type.rawValue
        ]
        guard let post = post else { return }
        value["postID"] = post.postID
        notificationRef.child(post.uid).childByAutoId().updateChildValues(value)
    }
    
}
