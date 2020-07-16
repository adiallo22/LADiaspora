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
private let postReplies = Constants.References.db.child("post_replies")
private let postLikes = Constants.References.db.child("post_likes")
private let userLikes = Constants.References.db.child("user_likes")

private let followersRef = Constants.References.db.child("followers")

struct PostService {
    
    static let shared = PostService()
    
    func uploadPostToDB(withConfig config: uploadPostCongig, caption : String, completion: @escaping(Error?, DatabaseReference)->Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let values = [
                "uid": uid,
                "likes": 0,
                "repost": 0,
                "timestamp": Int(Date().timeIntervalSince1970),
                "caption": caption
            ] as [String : Any]
        switch config {
        case .post:
            let ref = postRef.childByAutoId()
            guard let key = ref.key else { return }
            ref.updateChildValues(values) { (err, dataref) in
                userPostRef.child(uid).updateChildValues([key:1], withCompletionBlock: completion)
            }
        case .reply(let post):
            postReplies.child(post.postID).childByAutoId().updateChildValues(values, withCompletionBlock: completion)
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
    
    func fetchPostOfFollowedUser(completion: @escaping([Post]) -> Void) {
        var posts = [Post]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        followersRef.child(uid).observe(.childAdded) { snapshot in
            let uid = snapshot.key
            userPostRef.child(uid).observe(.childAdded) { snapshot in
                let key = snapshot.key
                self.fetchNotifiedPost(withPostID: key) { post in
                    posts.insert(post, at: 0)
                    completion(posts)
                }
            }
        }
        userPostRef.child(uid).observe(.childAdded) { snapshot in
            let key = snapshot.key
            self.fetchNotifiedPost(withPostID: key) { post in
                posts.insert(post, at: 0)
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
    
    func fetchPostReplies(fromPost post: Post, completion: @escaping([Post]) -> Void) {
        var posts = [Post]()
        postReplies.child(post.postID).observe(.childAdded) { (snapshot) in
            let key = snapshot.key
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
    
    func fetchLikedPosts(fromUser user: User, completion: @escaping([Post]) -> Void) {
        var posts = [Post]()
        userLikes.child(user.uid).observe(.childAdded) { snapshot in
            let key = snapshot.key
            self.fetchNotifiedPost(withPostID: key) { post in
                posts.insert(post, at: 0)
                completion(posts)
            }
        }
    }
    
    func likePost(of post: Post, completion: @escaping(Error?, DatabaseReference)->Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let likes = post.isLiked ? post.likes - 1 : post.likes + 1
        //updates likes count on database
        postRef.child(post.postID).child("likes").setValue(likes)
        if post.isLiked {
            userLikes.child(uid).child(post.postID).removeValue() { err, ref in
                postLikes.child(post.postID).removeValue(completionBlock: completion)
            }
        } else {
            userLikes.child(uid).updateChildValues([post.postID:1]) { err, ref in
                postLikes.child(post.postID).updateChildValues([uid:1], withCompletionBlock: completion)
            }
        }
    }
    
    func checkIfUserLiked(post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        userLikes.child(uid).child(post.postID).observeSingleEvent(of: .value) { snapshot in
            completion(snapshot.exists())
        }
    }
    
    func fetchNotifiedPost(withPostID postID: String, completion: @escaping(Post) -> Void) {
        postRef.child(postID).observeSingleEvent(of: .value) { (snapshot) in
            guard let values = snapshot.value as? [String:Any] else { return }
            guard let uid = values["uid"] as? String else { return }
            UserService.shared.fetchUserInfo(uid: uid) { (user) in
                let post = Post.init(user: user, postID: postID, values: values)
                completion(post)
            }
        }

    }
    
}
