//
//  LoginVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
    }
    
    @IBAction func signupClicked(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.toSignUp, sender: self)
    }
}

//MARK: - helpers

extension LoginVC {
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        //
        Util().designThetextfield(withTextField: emailtf)
        Util().designThetextfield(withTextField: passwordtf)
        Util().roundButton(withButton: loginButton)
    }
    
}
