//
//  SignupVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var fullnametf: UITextField!
    @IBOutlet weak var usernametf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    @IBAction func profileImagePicked(_ sender: UIButton) {
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
        profileImageButton.setImage(UIImage.init(named: "pickprofile"), for: .normal)
        Util().designThetextfield(withTextField: fullnametf)
        Util().designThetextfield(withTextField: usernametf)
        Util().designThetextfield(withTextField: emailtf)
        Util().designThetextfield(withTextField: passwordtf)
        Util().roundButton(withButton: signupButton)
    }
    
}
