//
//  MainTabBar.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import Firebase

private let loginSB = "Login"

class MainTabBar: UITabBarController {
    
    var user : User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedVC else { return }
            feed.user = user!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        signOutUser()
        checkUserLogStatus()
    }

}

//MARK: - Helpers

extension MainTabBar {
    
    func checkUserLogStatus() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                self.changeRootToLogin()
            }
        } else {
            fetchUserInfo()
        }
    }
    
    func changeRootToLogin() {
        let main : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginvc = main.instantiateViewController(withIdentifier: loginSB) as! LoginVC
        loginvc.modalPresentationStyle = .fullScreen
        present(loginvc, animated: false, completion: nil)
        
    }
    
    func signOutUser() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

//MARK: - fetching...

extension MainTabBar {
    
    func fetchUserInfo() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUserInfo(uid: uid) { [weak self] user in
            guard let self = self else { return }
            self.user = user
        }
        
    }
    
}

