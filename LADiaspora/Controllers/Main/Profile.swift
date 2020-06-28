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
            print(posts)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var x =  ["1", "2", "3"]
    
    var tappedUser : User?
    
    var test = ["1", "2", "3"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 130
        //delegation
        tableView.dataSource = self
        tableView.delegate = self
        //height of the header cell
        tableView.sectionHeaderHeight = 260
        //
        fetchUserPost()
    
    }
    
    func fetchUserPost() {
        guard let user = tappedUser else { return }
        PostService.shared.fetchUserPost(withUser: user) { [weak self] (posts) in
            self?.posts = posts
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        //cell.post = posts[indexPath.row]
        cell?.textLabel?.text = x[indexPath.row]
        return cell!
    }
}

