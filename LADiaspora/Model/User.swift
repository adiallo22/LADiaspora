//
//  user.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/14/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct User {
    
    var username : String
    var fullname : String
    var email : String
    var profileURL : String
    var uid : String
    
    init(uid: String, values: [String:Any]) {
        self.uid = uid
        self.fullname = values["full name"] as? String ?? ""
        self.email = values["email"] as? String ?? ""
        self.profileURL = values["profileURL"] as? String ?? ""
        self.username = values["username"] as? String ?? ""
    }
    
}
