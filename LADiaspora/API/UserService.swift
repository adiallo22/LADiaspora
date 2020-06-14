//
//  UserService.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/14/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Firebase

struct UserService {
    
    static let shared = UserService()
    
    func fetchUserFeed() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Constants.References.db.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let values = snapshot.value as? [String:Any] else { return }
            guard let fullname = values["full name"] as? String,
                let username = values["username"] as? String,
                let profileURL = values["profileURL"] as? String else { return }
        }
    }
    
}
