//
//  UserService.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/14/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Firebase

private let ref = Constants.References.db.child("users")
private let followersRef = Constants.References.db.child("followers")
private let followingsRef = Constants.References.db.child("following")

struct UserService {
    
    typealias completionHandler = (Error?, DatabaseReference) -> Void
    
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
        var users = [User]()
        ref.observe(.childAdded) { (snapshot) in
            let key = snapshot.key
            let value = snapshot.value as! [String:Any]
            let user = User.init(uid: key, values: value)
            users.append(user)
            completion(users)
        }
    }
    
    func followUser(uid: String, completion: @escaping(completionHandler)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        followingsRef.child(uid).updateChildValues([currentUid:1]) { (err, ref) in
            followersRef.child(currentUid).updateChildValues([uid:1]) { (err, ref) in
                completion(err, ref)
            }
        }
    }
    
    func unfollowUser(uid: String, completion: @escaping(completionHandler)) {
        guard let currenUid = Auth.auth().currentUser?.uid else { return }
        followingsRef.child(uid).child(currenUid).removeValue { (err, dataref) in
            followersRef.child(currenUid).child(uid).removeValue { (err, dataref) in
                completion(err, dataref)
            }
        }
    }
    
    func isUserFollowedOrNot(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        followingsRef.child(currentUid).child(uid).observeSingleEvent(of: .value) { (snapshot) in
            completion(snapshot.exists())
        }
    }
    
    func fetchUserStats(uid: String, completion: @escaping() -> Void) {
        followersRef.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            let followers = snapshot.children.allObjects.count
            print("\(followers) followers")
            followingsRef.child(uid).observeSingleEvent(of: .value) { (snapshot) in
                let following = snapshot.children.allObjects.count
                print("\(following) following")
            }
        }
    }
    
}
