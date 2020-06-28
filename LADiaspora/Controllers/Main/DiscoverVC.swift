//
//  DiscoverVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class DiscoverVC: UIViewController {

    @IBOutlet weak var newPostButton: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 60

        configureUI()
        fetchUser()
    }
    
    @IBAction func newPostClicked(_ sender: UIButton) {
    }
    
}

//MARK: - Helpers

extension DiscoverVC {
    
    func configureUI() {
        navigationItem.title = Constants.Titles.discover
        newPostButton.setNewPostButton()
    }
    
    func fetchUser() {
        UserService.shared.fetchUsers { (users) in
            print("okay")
        }
    }
    
}

//MARK: - delegate and data source

extension DiscoverVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected..")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.discoverUserCell) as! DiscoverUserCell
        return cell
    }
}

