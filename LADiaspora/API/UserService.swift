//
//  UserService.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/14/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Firebase

private let ref = Constants.References.db.child("users")

struct UserService {
    
    static let shared = UserService()
    
    //pass user to the controller calling this function
    func fetchUserInfo(uid: String, completion: @escaping(User)->Void) {
        //guard let uid = Auth.auth().currentUser?.uid else { return }
        ref.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let values = snapshot.value as? [String:Any] else { return }
            let user = User.init(uid: uid, values: values)
            completion(user)
        }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        ref.observe(.childAdded) { (snapshot) in
            print(snapshot)
        }
    }
    
}
