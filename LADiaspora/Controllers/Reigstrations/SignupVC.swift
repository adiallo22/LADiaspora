//
//  SignupVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    
}
