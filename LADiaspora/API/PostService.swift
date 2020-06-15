//
//  PostService.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/14/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Firebase

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
        Constants.References.db.child("posts").childByAutoId().setValue(values, withCompletionBlock: completion)
    }
    
    func fetchPost(completion: @escaping([Post])->Void) {
        var posts = [Post]()
        Constants.References.db.child("posts").observe(.childAdded) { (snapshot) in
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
    
}
