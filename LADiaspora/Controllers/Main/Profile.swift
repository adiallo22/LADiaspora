//
//  Profile.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/23/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class Profile: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    var replies = [Post]()
    var likes = [Post]()
    
    var pickedDataSource : [Post] {
        switch option {
        case .posts:
            return posts
        case .replies:
            return replies
        case .likes:
            return likes
        }
    }
    
    var option : FilterOptions = .posts {
        didSet { tableView.reloadData() }
    }
    
    var tappedUser : User?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // call apis
        fetchUserPost()
        checkIfUserIsFollwed()
        fetchUserStats()
        fetchLikedPost()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 130
        tableView.rowHeight = UITableView.automaticDimension
        //delegation
        tableView.dataSource = self
        tableView.delegate = self
        //height of the header cell
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 250
    
    }

}


//MARK: - api calls

extension Profile {
    
    func fetchUserPost() {
        guard let user = tappedUser else { return }
        PostService.shared.fetchUserPost(withUser: user) { [weak self] (posts) in
            guard let self = self else { return }
            self.posts = posts
            self.tableView.reloadData()
        }
    }
    
    func checkIfUserIsFollwed() {
        guard let user = tappedUser else { return }
        UserService.shared.isUserFollowedOrNot(uid: user.uid) { [weak self] isFollow in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tappedUser?.isFollowed = isFollow
            }
        }
    }
    
    func fetchUserStats() {
        guard let user = tappedUser else { return }
        UserService.shared.fetchUserStats(uid: user.uid) { [weak self] stats in
            self?.tappedUser?.stats = stats
            self?.tableView.reloadData()
        }
    }
    
    func fetchLikedPost() {
        guard let user = tappedUser else { return }
        PostService.shared.fetchLikedPosts(fromUser: user) { [weak self] posts in
            guard let self = self else { return }
            self.likes = posts
        }
    }

}


//MARK: - delegate and data source

extension Profile : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickedDataSource.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.profileHeaderCell) as! ProfileHeaderCell
        cell.user = tappedUser
        cell.followDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.postCell) as! PostTVC
        cell.post = pickedDataSource[indexPath.row]
        return cell
    }
}

//MARK: - HandleFollowUser

extension Profile : HandleFollowUser {
    
    func delegateFilterPicked(_ option: FilterOptions) {
        print(option)
    }
    
    func followBtnTapped(_ to: ProfileHeaderCell) {
        guard let user = tappedUser else { return }
        if user.isCurrentUser {
            return 
        }
        if user.isFollowed == false {
            UserService.shared.followUser(uid: user.uid) { [weak self] (error, ref) in
                guard let self = self else { return }
                self.tappedUser?.isFollowed = true
                NotificationService.shared.uploadNotification(withType: .follow, user: self.tappedUser)
                self.tableView.reloadData()
            }
        } else {
            UserService.shared.unfollowUser(uid: user.uid) { [weak self] (error, ref) in
                guard let self = self else { return }
                self.tappedUser?.isFollowed = false
                self.tableView.reloadData()
            }
        }
    }
    
}

