//
//  Constants.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/8/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation
import Firebase

struct Constants {
    
    struct Segues {
        static let toSignUp = "toSignUp"
        static let toNewPost = "toNewPost"
        static let toProfile = "toProfile"
    }
    
    struct Titles {
        static let home = "Home"
        static let discover = "Discover"
        static let notification = "Notifications"
        static let message = "Messages"
    }
    
    struct References {
        static let db = Database.database().reference()
        static let imageDB = Storage.storage().reference()
    }
    
}
