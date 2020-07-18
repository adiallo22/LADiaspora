//
//  UploadPostViewModel.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/30/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

enum uploadPostCongig {
    case post
    case reply(Post)
}

struct UploadPostViewModel {
    
    var actionButton : String
    var placeholder : String
    var shouldShowReplyLabel : Bool
    var replyLabel : String?
    
    init(config: uploadPostCongig) {
        switch config {
        case .post:
            actionButton = "Post"
            placeholder = "Whats happening?"
            shouldShowReplyLabel = false
        case .reply(let post):
            actionButton = "Reply"
            placeholder = "Whats your reply"
            shouldShowReplyLabel = true
            replyLabel = "replying to @\(post.user.username)"
        }
    }
    
}
