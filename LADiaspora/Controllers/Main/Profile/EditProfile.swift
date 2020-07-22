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
    
    private lazy var header = HeaderViewEdit.init(user: user!)
    
    private let imagePicker = UIImagePickerController()
    
    private var newImage : UIImage? {
        didSet {
            header.profileIMG.image = newImage
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configPicker()
        configTableView()
        editNavBar()
        header.delegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        header.backgroundColor = .clear
    }
    
}

//MARK: - delegate and datasource

extension EditProfile : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EditProfilOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.editDetaiCell) as! EditDetaiCell
        cell.delegate = self
        guard let option = EditProfilOptions.init(rawValue: indexPath.row) else { return cell }
        cell.option = option
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
    
    func configTableView() {
        header.frame = CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 180)
        tableView.tableHeaderView = header
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

//MARK: - EditProfileDelegate

extension EditProfile : EditProfileDelegate {
    
    func passEditClicked() {
        present(imagePicker, animated: true, completion: nil)
    }
    
}

//MARK: - image picker

extension EditProfile : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let img = info[.editedImage] as? UIImage else { return }
        self.newImage = img
        dismiss(animated: true, completion: nil)
    }
    
    func configPicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
}

//MARK: - EditDelegate

extension EditProfile : EditDelegate {
    
    func didFinishEditingText(_ cell: EditDetaiCell) {
        print("finished editing... \(cell.tf.text!)")
    }
    
}
