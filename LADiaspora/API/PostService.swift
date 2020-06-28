//
//  PostService.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/14/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Firebase

private let userPostRef = Constants.References.db.child("user_posts")
private let postRef = Constants.References.db.child("posts")

struct PostService {
    
    static let shared = PostService()
    
    func uploadPostToDB(caption : String, completion: @escaping(Error?, DatabaseReference)->Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let values = [
            "uid": uid,
            "likes": 0,
            "repost": 0,
            "timestamp": Int(Date().timeIntervalSince1970),
            "caption": caption
            ] as [String : Any]
        let ref = postRef.childByAutoId()
        guard let key = ref.key else { return }
        ref.updateChildValues(values) { (err, dataref) in
            userPostRef.child(uid).updateChildValues([key:1], withCompletionBlock: completion)
        }
    }
    
    func fetchPost(completion: @escaping([Post])->Void) {
        var posts = [Post]()
        postRef.observe(.childAdded) { (snapshot) in
            let postID = snapshot.key
            guard let values = snapshot.value as? [String:Any] else { return }
            guard let uid = values["uid"] as? String else { return }
            UserService.shared.fetchUserInfo(uid: uid) { (user) in
                let post = Post.init(user: user, postID: postID, values: values)
                posts.insert(post, at: 0)
                //allow the controller using this function to be able to access the array of posts
                completion(posts)
            }
        }
    }
    
    func fetchUserPost(withUser user : User, completion: @escaping([Post]) -> Void) {
        var posts = [Post]()
        userPostRef.child(user.uid).observe(.childAdded) { (snapshot) in
            let key = snapshot.key
            postRef.child(key).observeSingleEvent(of: .value) { (snapshot) in
                guard let values = snapshot.value as? [String:Any] else { return }
                guard let uid = values["uid"] as? String else { return }
                UserService.shared.fetchUserInfo(uid: uid) { (user) in
                    let post = Post.init(user: user, postID: key, values: values)
                    posts.insert(post, at: 0)
                    //allow the controller using this function to be able to access the array of posts
                    completion(posts)
                }
            }
        }
    }
    
}
