//
//  ActionSheetViewModel.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/4/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct ActionSheetViewModel {
    
    private var user : User
    
    var options : [ActionSheetOption] {
        var result = [ActionSheetOption]()
        if user.isCurrentUser {
            result.append(.delete)
        } else {
            let followOpt : ActionSheetOption = user.isFollowed ? .unfollow(user) : .follow(user)
            result.append(followOpt)
        }
        result.append(.report)
        return result
    }
    
    init(user : User) {
        self.user = user
    }
    
}

//MARK: - <#section heading#>

enum ActionSheetOption {
    
    case follow(User)
    case unfollow(User)
    case report
    case delete
    
    var description : String {
        switch self {
        case .follow(let user):
            return "Follow @\(user.username)"
        case .unfollow(let user):
            return "Unfollow @\(user.username)"
        case .report:
            return "Report Tweet"
        case .delete:
            return "Delete Tweet"
        }
    }
}
