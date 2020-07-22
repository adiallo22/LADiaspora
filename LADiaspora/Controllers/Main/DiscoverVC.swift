//
//  DiscoverVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

private let profileID = "profile"

class DiscoverVC: UIViewController {

    @IBOutlet weak var newPostButton: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    private var users = [User]() {
        didSet{
            tableview.reloadData()
        }
    }
    
    private var usersFiltered = [User]() {
        didSet {
            tableview.reloadData()
        }
    }
    
    private var inSearchMode : Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    private let searchController = UISearchController.init(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 60

        configureUI()
        fetchUser()
        configSearchController()
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
        UserService.shared.fetchUsers { [weak self] (users) in
            self?.users = users
        }
    }
    
    func configSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        //
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search users"
        definesPresentationContext = false
    }
    
}

//MARK: - delegate and data source

extension DiscoverVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? usersFiltered[indexPath.row] : users[indexPath.row]
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        let profile = main.instantiateViewController(withIdentifier: profileID) as! Profile
        profile.tappedUser = user
        navigationController?.pushViewController(profile, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? usersFiltered.count : users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.discoverUserCell) as! DiscoverUserCell
        let user = inSearchMode ? usersFiltered[indexPath.row] : users[indexPath.row]
        cell.user = user
        return cell
    }
}

//MARK: - search updater

extension DiscoverVC : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searched = searchController.searchBar.text?.lowercased() else { return }
        usersFiltered = users.filter({ user in
            return user.username.contains(searched) || user.fullname.contains(searched)
        })
    }
}

