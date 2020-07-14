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
    
    var actionSheet : ActionSheet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        //
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 250
        tableView.estimatedRowHeight = 130
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchReplies()
    }

}


//MARK: - helpers

extension PostDetails {
    
    func fetchReplies() {
        PostService.shared.fetchPostReplies(fromPost: post) { [weak self] (posts) in
            guard let self = self else { return }
            self.replies = posts
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
        cell.actionDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.postCell) as! PostTVC
        cell.post = replies[indexPath.row]
        return cell
    }
}


//MARK: - ActionSheetHandler


extension PostDetails : ActionSheetHandler {
    func actionSheetTapped() {
        actionSheet.presentActionSheet()
    }
}
