//
//  FeedVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SDWebImage
import Social

private let postDetailsID = "PostDetails"
private let newPostVC = "NewPostVC"

class FeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var user : User? {
        didSet {
//            invokeUserProfileIMG()
        }
    }
    
    var profileUser : User?
    
    var posts = [Post]() {
        didSet { self.tableView.reloadData() }
    }

    @IBOutlet weak var newPostButton: UIButton!
    @IBOutlet weak var profileIMGButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchPostOfFollowedUser()
    }
    
    private var refresh : UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 130
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    @IBAction func newPostClicked(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.toNewPost, sender: self)
    }
    

}

//MARK: - Helpers

extension FeedVC {
    
    func configureUI() {
        navigationItem.title = Constants.Titles.home
        newPostButton.setNewPostButton()
        refreshTable()
    }
    
    func invokeUserProfileIMG() {
        guard let imageURL = user?.profileURL else { return }
        guard let url = URL.init(string: imageURL) else { return }
        let profileIMGView = UIImageView.init()
        profileIMGView.frame = CGRect.init(x: 0, y: 0, width: 32, height: 32)
        profileIMGView.layer.cornerRadius = profileIMGView.layer.frame.width / 2.0
        profileIMGView.layer.masksToBounds = true
        profileIMGView.sd_setImage(with: url, completed: nil)
        navigationItem.leftBarButtonItem?.customView = profileIMGView
    }
    
//    func fetchPosts() {
//        refresh?.beginRefreshing()
//        PostService.shared.fetchPost { [weak self] posts in
//            guard let self = self else { return }
//            self.refresh?.endRefreshing()
//            self.posts = posts
//            self.persistLikePost(withPost: posts)
//        }
//    }
    
    func fetchPostOfFollowedUser() {
        refresh?.beginRefreshing()
        PostService.shared.fetchPostOfFollowedUser { [weak self] posts in
            guard let self = self else { return }
            self.posts = posts
            self.posts = self.posts.sorted { p0, p1 in
                p0.timestamp < p1.timestamp }
            self.persistLikePost(withPost: self.posts)
            self.refresh?.endRefreshing()
        }
    }
    
    func persistLikePost(withPost posts: [Post]) {
        persistLikes(withPosts: posts)
    }
    
    func persistLikes(withPosts posts: [Post]) {
        //retrieve every post with their indexes
        for (i, post) in posts.enumerated() {
            PostService.shared.checkIfUserLiked(post: post) { [weak self] isLiked in
                //if post is not liked, return and move to the next post
                guard isLiked == true else { return }
                //else post is liked, persist like
                self?.posts[i].isLiked = true
            }
        }
    }
    
    func refreshTable() {
        refresh = UIRefreshControl()
        refresh?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refresh
    }
    
    @objc func handleRefresh() {
        fetchPostOfFollowedUser()
    }
    
}

//MARK: - segues

extension FeedVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.Segues.toNewPost {
            let destVC = segue.destination as! NewPostVC
            guard let usr = user else { return }
            destVC.user = usr
            destVC.config = .post
        }
        if segue.identifier == Constants.Segues.toProfile {
            let destVC = segue.destination as! Profile
            destVC.tappedUser = profileUser
        }
        
    }
    
}

//MARK: - delegate and datasource

extension FeedVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.postCell) as! PostTVC
        cell.post = posts[indexPath.row]
        cell.tappedDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        let detailsPost = main.instantiateViewController(identifier: postDetailsID) as! PostDetails
        let post = posts[indexPath.row]
        detailsPost.post = post
        detailsPost.actionSheet = ActionSheet.init(user: post.user)
        navigationController?.pushViewController(detailsPost, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - HandPostDelegate

extension FeedVC : HandPostDelegate {
    
    func handleLikepost(_ cell: PostTVC) {
        guard let post = cell.post else { return }
        PostService.shared.likePost(of: post) { (err, ref) in
            if let error = err {
                print(error.localizedDescription)
            } else {
                cell.post?.isLiked.toggle()
                let likes = post.isLiked ? post.likes - 1 : post.likes + 1
                cell.post?.likes = likes
                if cell.post?.isLiked ?? false {
                    NotificationService.shared.uploadNotification(withType: .like, post: post)
                }
            }
        }
    }
    
    func handleSharedPost(_ cell: PostTVC) {
        guard let caption = cell.post?.caption else { return }
        let activity = UIActivityViewController(activityItems: [caption], applicationActivities: nil)
        present(activity, animated: true, completion: nil)
    }
    
    
    func handleReplyPost(_ cell: PostTVC) {
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        let newPost = main.instantiateViewController(identifier: newPostVC) as! NewPostVC
        guard let post = cell.post else { return }
        newPost.config = .reply(post)
        present(newPost, animated: true, completion: nil)
//        navigationController?.pushViewController(newPost, animated: true)
    }
    
    func profileImageTapped(_ cell: PostTVC) {
        guard let user = cell.post?.user else { return }
        profileUser = user
        performSegue(withIdentifier: Constants.Segues.toProfile, sender: self)
    }
    
}
