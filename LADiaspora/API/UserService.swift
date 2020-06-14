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
            let user = User.init(uid: uid, values: values)
            print(user.email)
            print(user.fullname)
            print(user.profileURL)
            print(user.uid)
            print(user.username)
        }
    }
    
}
