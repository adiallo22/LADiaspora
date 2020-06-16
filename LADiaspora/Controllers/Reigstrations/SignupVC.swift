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
                let imageReference = Constants.References.imageDB.child("profile_images").child(NSUUID().uuidString)
                //compress profile image to be uploaded on Storage
                guard let imageData = profileImg?.jpegData(compressionQuality: 0.5) else { return }
                //upload profile image to the Storage
                uploadProfileToStorageWith(reference: imageReference, imageData: imageData)
                changeRoot()
//                dismissCurrentControllerAndShowTab()
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

//MARK: - database handling

extension SignupVC {
    
    func uploadProfileToStorageWith(reference: StorageReference, imageData: Data) {
        reference.putData(imageData, metadata: nil) { (meta, error) in
            reference.downloadURL { (url, error) in
                //hold the url of the profile image saved in Storage
                guard let profileURL = url?.absoluteString else { return }
                print(profileURL)
                guard let email = self.emailtf.text,
                    let pwd = self.passwordtf.text,
                    let username = self.usernametf.text,
                    let fullname = self.fullnametf.text else { return }
                let user = AuthCredential(fullname: fullname, username: username, email: email, password: pwd, profileURL: profileURL)
                //upload textfields and image url to database
                self.createNewUser(withCredentials: user)
            }
        }
    }
    
    func createNewUser(withCredentials : AuthCredential) {
        Auth.auth().createUser(withEmail: withCredentials.email, password: withCredentials.password, completion: { (result, error) in
            if error != nil {
                self.setTheError(withError: error!.localizedDescription)
            } else {
                let uid = result?.user.uid
                let values = ["full name":withCredentials.fullname,
                              "email":withCredentials.email,
                              "username":withCredentials.username.lowercased(),
                              "profileURL":withCredentials.profileURL]
                //reference to database and upload values
                let reference = Constants.References.db.child("users").child("\(uid!)")
                reference.setValue(values)
            }
        })
    }
    
}
