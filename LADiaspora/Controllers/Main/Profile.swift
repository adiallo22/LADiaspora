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
            print("posts data is received..")
        }
    }
    
    var test = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegation
        tableView.dataSource = self
        tableView.delegate = self
        //height of the header cell
        tableView.sectionHeaderHeight = 200
    
    }

}

//MARK: - delegate and data source

extension Profile : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.profileHeaderCell) as! ProfileHeaderCell
        cell.backgroundColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = test[indexPath.row]
        return cell!
    }
}
