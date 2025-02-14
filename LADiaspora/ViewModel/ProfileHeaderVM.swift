//
//  ProfileHeaderVM.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/25/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

enum FilterOptions: Int, CaseIterable {
    
    case posts
    case replies
    case likes
    
    var Description : String {
        switch self {
        case .likes:
            return "Likes"
        case .posts:
            return "Posts"
        case .replies:
            return "Replies"
        }
    }
    
}


//MARK: - <#section heading#>


struct ProfileHeaderVM {
    
    private var user : User
    
    var followers : String {
        return "\(user.stats?.followers ?? 0) followers"
    }
    
    var following : String {
        return "\(user.stats?.following ?? 0) following"
    }
    
    var profileBtnTitle : String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            if user.isFollowed {
                return "Following"
            } else {
                return "Follow"
            }
        }
    }
    
    var fullname : String {
        return user.fullname
    }
    
    var username : String {
        return "@\(user.username)"
    }
    
    var url : URL {
        return URL.init(string: user.profileURL)!
    }
    
    var bio : String {
        return user.bio
    }
    
    init(user: User) {
        self.user = user
    }
    
}
