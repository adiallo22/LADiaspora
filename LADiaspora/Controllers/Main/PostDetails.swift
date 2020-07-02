//
//  PostDetails.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/29/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class PostDetails: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var post : Post!
    
    private var replies = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        //
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 250
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        //
        fetchReplies()
        
    }

}


//MARK: - helpers

extension PostDetails {
    
    func fetchReplies() {
        PostService.shared.fetchPostReplies(fromPost: post) { [weak self] (posts) in
            self?.replies = posts
        }
    }
    
}


//MARK: - delegate and data source

extension PostDetails : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replies.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.postCellHeader) as! PostDetailsHeaderCell
        cell.post = post
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.postCell) as! PostTVC
        cell.post = replies[indexPath.row]
        return cell
    }
}
