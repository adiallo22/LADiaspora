//
//  NotificationVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import Firebase

private let profileSB = "profile"
private let postDetailsSB = "PostDetails"

class NotificationVC: UIViewController {

    @IBOutlet weak var newPostButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var notifications = [Notification]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 60
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchNotifications()
    }

    @IBAction func newPostClicked(_ sender: UIButton) {
        print("new post clicked..")
    }
    
}


//MARK: - Helpers

extension NotificationVC {
    
    func configureUI() {
        navigationItem.title = Constants.Titles.notification
        newPostButton.setNewPostButton()
    }
    
    func openUserProfile(withUser user: User) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let profile = main.instantiateViewController(identifier: profileSB) as! Profile
        profile.tappedUser = user
        navigationController?.pushViewController(profile, animated: true)
    }
    
    func openPostDetails(withPost post: Post) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let details = main.instantiateViewController(identifier: postDetailsSB) as! PostDetails
        details.post = post
        navigationController?.pushViewController(details, animated: true)
    }
    
}


//MARK: - datasource and delegate

extension NotificationVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let notification = notifications[indexPath.row]
        guard let postID = notification.postID else { return }
        PostService.shared.fetchNotifiedPost(withPostID: postID) { [weak self] post in
            guard let self = self else { return }
            self.openPostDetails(withPost: post)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.notificationCell) as! NotificationCell
        cell.notification = notifications[indexPath.row]
        cell.delegate = self
        return cell
    }
    
}
    
    
//MARK: - api

extension NotificationVC {
    
    func fetchNotifications() {
        NotificationService.shared.fetchNotifications { [weak self] notifications in
            guard let self = self else { return }
            self.notifications = notifications
            self.checkFollowStatus(withNotifications: notifications)
        }
    }
    
    fileprivate func checkFollowStatus(withNotifications notifications: [Notification]) {
        for (i, notification) in notifications.enumerated() {
            let user = notification.user
            if notification.type == .follow {
                UserService.shared.isUserFollowedOrNot(uid: user.uid) { isFollowed in
                    self.notifications[i].user.isFollowed = isFollowed
                }
            }
        }
    }
    
}

//MARK: - NotificationCellDelegate

extension NotificationVC : NotificationCellDelegate {
    
    func handleFollowTapped(_ cell: NotificationCell) {
        print("followed..")
    }
    
    func handleProfileTaped(_ cell: NotificationCell) {
        guard let user = cell.notification?.user else { return }
        openUserProfile(withUser: user)
    }
    
}

