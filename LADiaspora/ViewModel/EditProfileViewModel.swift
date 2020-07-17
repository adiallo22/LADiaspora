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
