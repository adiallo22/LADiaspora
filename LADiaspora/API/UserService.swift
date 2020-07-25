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
    
    func fetchUserStats(uid: String, completion: @escaping(UserFollowStats) -> Void) {
        followersRef.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            let followers = snapshot.children.allObjects.count
            followingsRef.child(uid).observeSingleEvent(of: .value) { (snapshot) in
                let following = snapshot.children.allObjects.count
                let stats = UserFollowStats.init(following: following, followers: followers)
                completion(stats)
            }
        }
    }
    
    func saveUserProfileData(user: User, completion: @escaping(completionHandler)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let values = [
            "full name":user.fullname,
            "username":user.username,
            "bio":user.bio
        ]
        ref.child(uid).updateChildValues(values, withCompletionBlock: completion)
    }
    
    func updateProfileIMG(withImage image: UIImage, completion: @escaping(Result<URL, Error>)->Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let fileName = NSUUID().uuidString
        guard let img = image.jpegData(compressionQuality: 0.5) else { return }
        let reference = Constants.References.imageDB.child("profile_images").child(fileName)
        reference.putData(img, metadata: nil) { (meta, err) in
            if err != nil {
                completion(.failure(err!))
            } else {
                reference.downloadURL { (url, err) in
                    if err != nil {
                        completion(.failure(err!))
                    } else {
                        guard let imageURL = url?.absoluteURL else { return }
                        let values = ["profileURL":"\(imageURL)"]
                        ref.child(uid).updateChildValues(values) { (err, refer) in
                            if err != nil {
                                completion(.failure(err!))
                            } else {
                                completion(.success(imageURL))
                            }
                        }
                    }
                }
            }
        }
    }
    
}
