//
//  EditProfileViewModel.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/17/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

enum EditProfilOptions: Int, CaseIterable {
    
    case fullname
    case username
    case bio
    
    var description : String {
        switch self {
        case .fullname:
            return "Full Name"
        case .username:
            return "Username"
        case .bio:
            return "Bio"
        }
    }
    
}

//MARK: - <#section heading#>

struct EditProfileViewModel {
    
    private let user : User
    
    var option : EditProfilOptions
    
    var titleText : String {
        return option.description
    }
    
    var optionVal : String? {
        switch option {
        case .fullname:
            return user.fullname
        case .username:
            return user.username
        case .bio:
            return user.bio
        }
    }
    
//    var hideTextField : Bool {
//        return option == .bio
//    }
//
//    var hideTextView : Bool {
//        return option != .bio
//    }
    
    init(user: User, option: EditProfilOptions) {
        self.user = user
        self.option = option
    }
    
}
