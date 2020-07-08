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
    
    var posts : [Post] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var x =  ["1", "2", "3"]
    
    var tappedUser : User?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        // call apis
        fetchUserPost()
        checkIfUserIsFollwed()
        fetchUserStats()
    
    }

}


//MARK: - api calls

extension Profile {
    
    func fetchUserPost() {
        guard let user = tappedUser else { return }
        PostService.shared.fetchUserPost(withUser: user) { [weak self] (posts) in
            self?.posts = posts
        }
    }
    
    func checkIfUserIsFollwed() {
        guard let user = tappedUser else { return }
        UserService.shared.isUserFollowedOrNot(uid: user.uid) { [weak self] (isFollow) in
            self?.tappedUser?.isFollowed = isFollow
            DispatchQueue.main.async {
                self?.tableView.reloadData()
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

}


//MARK: - delegate and data source

extension Profile : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.profileHeaderCell) as! ProfileHeaderCell
        cell.user = tappedUser
        cell.followDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        //cell.post = posts[indexPath.row]
//        cell?.textLabel?.text = x[indexPath.row]
        return cell!
    }
}

extension Profile : HandleFollowUser {
    
    func followBtnTapped(_ to: ProfileHeaderCell) {
        guard let user = tappedUser else { return }
        if user.isCurrentUser {
            return 
        }
        if user.isFollowed == false {
            UserService.shared.followUser(uid: user.uid) { [weak self] (error, ref) in
                self?.tappedUser?.isFollowed = true
                NotificationService.shared.uploadNotification(withType: .follow, user: self?.tappedUser)
                self?.tableView.reloadData()
            }
        } else {
            UserService.shared.unfollowUser(uid: user.uid) { [weak self] (error, ref) in
                self?.tappedUser?.isFollowed = false
                self?.tableView.reloadData()
            }
        }
    }
    
}

