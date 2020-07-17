//
//  EditProfile.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/17/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class EditProfile: UIViewController {
    
    var user : User? {
        didSet {
            print("user to be modified is \(user?.username)")
        }
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        editNavBar()
        
    }
    
}

//MARK: - delegate and datasource

extension EditProfile : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.editProfileHeaderCell) as! EditProfileHeaderCell
        return cell
    }
}

//MARK: - navigationbar

extension EditProfile {
    
    func editNavBar() {
        navigationItem.title = "Edit Profile"
        navigationController?.navigationBar.tintColor = .orange
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(doneEdition))
    }
    
}

//MARK: - helpers

extension EditProfile {
    
    @objc func doneEdition() {
        navigationController?.popViewController(animated: true)
    }
    
}
