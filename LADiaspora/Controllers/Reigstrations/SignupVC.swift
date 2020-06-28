//
//  SignupVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import Firebase

class SignupVC: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var fullnametf: UITextField!
    @IBOutlet weak var usernametf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var profileImg : UIImage?
    
    private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        imagePicker.delegate = self
        errorLabel.alpha = 0
        
    }
    
    @IBAction func profileImagePicked(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        //if profile image is not picked, set error label
        if profileImg == nil {
            setTheError(withError: "Please select a profile image")
        } else {
            //else, profile image was uploaded by user
            let error = checkForError()
            if error != nil {
                setTheError(withError: error!)
            } else {
                //all textfields are filled by the user
                guard let fullname = fullnametf.text,
                        let username = usernametf.text,
                        let email = emailtf.text,
                        let pwd = passwordtf.text else { return }
                let authCredential = AuthCredential.init(fullname: fullname, username: username, email: email, password: pwd, profileIMG: profileImg!)
                AuthService.shared.registerUserWith(authCredential: authCredential) { (error, ref) in
                    if error != nil {
                        self.setTheError(withError: error!.localizedDescription)
                    } else {
                        self.presentingViewController?.dismiss(animated: true, completion: nil)
//                        self.changeRoot()
//                        dismissCurrentControllerAndShowTab()
                    }
                }
            }
        }
    }
    
    @IBAction func returnToSignClicked(_ sender: UIButton) {
        //return to the root view controller
        navigationController?.popToRootViewController(animated: true)
        navigationController?.modalPresentationStyle = .fullScreen
    }
    
}


//MARK: - Helpers


extension SignupVC {
    
    func configureUI() {
        // set profile image button
        profileImageButton.setImage(UIImage.init(named: "pickprofile"), for: .normal)
        fullnametf.underlineText()
        usernametf.underlineText()
        emailtf.underlineText()
        passwordtf.underlineText()
        signupButton.roundButton(withColor: .black)
    }
    
    func roundProfileImageButton() {
        profileImageButton.layer.cornerRadius = 64.0
        profileImageButton.layer.masksToBounds = true
        profileImageButton.imageView?.contentMode = .scaleAspectFit
        profileImageButton.imageView?.clipsToBounds = true
        profileImageButton.layer.borderWidth = 2
//        profileImageButton.layer.borderColor = UIColor.
    }
    
    //check for potential error
    func checkForError() -> String? {
        if fullnametf.text == "" || usernametf.text == "" || passwordtf.text == "" || emailtf.text == "" {
            return "Fields cannot be empty"
        }
        return nil
    }
    
    //set the error if exist
    func setTheError(withError : String) {
        errorLabel.text = withError
        errorLabel.alpha = 1
    }
    
    func changeRoot() {
        let main : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = main.instantiateViewController(withIdentifier: "MainTabBarVC") as! MainTabBar
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //since we have changed the root view controller to be the tab instead of login, we need to dismiss this controller
    func dismissCurrentControllerAndShowTab() {
        //hold the single window and have access to the root which is tab
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
        guard let mainTab = window.rootViewController as? MainTabBar else { return }
        //recheck the status after user enter credentials.
        mainTab.checkUserLogStatus()
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - image picker handler

extension SignupVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        profileImg = image
        profileImageButton.setImage(image, for: .normal)
        roundProfileImageButton()
        dismiss(animated: true, completion: nil)
    }
    
}
