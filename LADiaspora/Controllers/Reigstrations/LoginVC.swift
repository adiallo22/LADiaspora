//
//  LoginVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        errorLabel.alpha = 0
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        guard let email = emailtf.text, let pwd = passwordtf.text else { return }
        signUserIn(with: email, and: pwd)
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
        emailtf.underlineText()
        passwordtf.underlineText()
        loginButton.roundButton()
    }
    
    func changeRoot() {
        let main : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = main.instantiateViewController(withIdentifier: "MainTabBarVC") as! MainTabBar
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func detectError() -> String? {
        if emailtf.text == "" || passwordtf.text == "" {
            return "Fields cannot be empty"
        }
        return nil
    }
    
    func setError(with error : String) {
        errorLabel.text = error
        errorLabel.alpha = 1
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

//MARK: - signing

extension LoginVC {
    
    func signUserIn(with email: String, and password: String) {
        let error = detectError()
        if error != nil {
            setError(with: error!)
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.setError(with: error!.localizedDescription)
                } else {
                    //self.changeRoot()
                    self.dismissCurrentControllerAndShowTab()
                }
            }
        }
    }
    
}
