//
//  SignupVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class SignupVC: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var fullnametf: UITextField!
    @IBOutlet weak var usernametf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        imagePicker.delegate = self
        
    }
    
    @IBAction func profileImagePicked(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
    }
    
    @IBAction func returnToSignClicked(_ sender: UIButton) {
        //return to the root view controller
        navigationController?.popToRootViewController(animated: true)
    }
    
}

//MARK: - Helpers

extension SignupVC {
    
    func configureUI() {
        // set profile image button
        profileImageButton.setImage(UIImage.init(named: "pickprofile"), for: .normal)
        //
        Util().designThetextfield(withTextField: fullnametf)
        Util().designThetextfield(withTextField: usernametf)
        Util().designThetextfield(withTextField: emailtf)
        Util().designThetextfield(withTextField: passwordtf)
        Util().roundButton(withButton: signupButton)
    }
    
    func roundProfileImageButton() {
        profileImageButton.layer.cornerRadius = 64.0
        profileImageButton.layer.masksToBounds = true
        profileImageButton.imageView?.contentMode = .scaleAspectFit
        profileImageButton.imageView?.clipsToBounds = true
        profileImageButton.layer.borderWidth = 2
//        profileImageButton.layer.borderColor = UIColor.
    }
    
}

//MARK: - image picker handler

extension SignupVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        profileImageButton.setImage(image, for: .normal)
        roundProfileImageButton()
        dismiss(animated: true, completion: nil)
    }
    
}
