//
//  FeedVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SDWebImage

class FeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var user : User? {
        didSet {
//            invokeUserProfileIMG()
        }
    }
    
    var posts = [Post]() {
        didSet { self.tableView.reloadData() }
    }

    @IBOutlet weak var newPostButton: UIButton!
    @IBOutlet weak var profileIMGButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchPosts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 130
//        tableView.autoresizingMask = .flexibleHeight
        
    }
    
    @IBAction func newPostClicked(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.toNewPost, sender: self)
        //segue programatically
//        let storyborad = UIStoryboard(name: "Main", bundle: nil)
//        if let vc = storyborad.instantiateViewController(withIdentifier: "NewPostVC") as? NewPostVC {
//             self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    

}

//MARK: - Helpers

extension FeedVC {
    
    func configureUI() {
        navigationItem.title = Constants.Titles.home
        newPostButton.setNewPostButton()
        
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
    
    func fetchPosts() {
        PostService.shared.fetchPost { (posts) in
            self.posts = posts
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        }
    }
    
}

//MARK: - segues

extension FeedVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.Segues.toNewPost {
            let destVC = segue.destination as! NewPostVC
            guard let usr = user else { return }
            destVC.user = usr
        }
        
    }
    
}

//MARK: - delegate and datasource

extension FeedVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTVC
        cell.post = posts[indexPath.row]
        cell.tappedProfileDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - HandPostDelegate

extension FeedVC : HandPostDelegate {
    
    func profileImageTapped(atCell cell: UITableViewCell) {
        performSegue(withIdentifier: Constants.Segues.toProfile, sender: self)
    }
    
}
