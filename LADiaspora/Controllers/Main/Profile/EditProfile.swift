//
//  EditProfile.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/17/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class EditProfile: UIViewController {
    
    var user : User?
    
    private let imagePicker = UIImagePickerController()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configPicker()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = 180
        editNavBar()
        
    }
    
}

//MARK: - delegate and datasource

extension EditProfile : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EditProfilOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.editProfileHeaderCell) as! EditProfileHeaderCell
        cell.user = self.user
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.editDetaiCell) as! EditDetaiCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let option = EditProfilOptions.init(rawValue: indexPath.row) else { return 0 }
        return option == .bio ? 100 : 48
    }
}

//MARK: - navigationbar

extension EditProfile {
    
    func editNavBar() {
        navigationItem.title = "Edit Profile"
        navigationController?.navigationBar.backgroundColor = .orange
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(doneEdition))
    }
    
}

//MARK: - helpers

extension EditProfile {
    
    @objc func doneEdition() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - EditProfileDelegate

extension EditProfile : EditProfileDelegate {
    
    func passEditClicked(_ cell: EditProfileHeaderCell) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}

//MARK: - image picker

extension EditProfile : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        print("picked..")
    }
    
    func configPicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
}
