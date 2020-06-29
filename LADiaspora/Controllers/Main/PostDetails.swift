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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.sectionHeaderHeight = 150
        tableView.rowHeight = 80
        
    }

}

//MARK: - delegate and data source

extension PostDetails : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellHeader")
        cell?.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "1"
        return cell!
    }
}
