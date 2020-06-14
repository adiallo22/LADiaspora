//
//  MainTabBar.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import Firebase

class MainTabBar: UITabBarController {
    
    var user : User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedVC else { return }
            feed.user = user!
            //print("user = \(user)")
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
    
    func fetchUserInfo() {
        UserService.shared.fetchUserInfo { (user) in
            self.user = user
        }
        
    }
    
    func checkUserLogStatus() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                self.changeRootToLogin()
            }
            print("no current user")
        } else {
            print("a user is logged in")
            fetchUserInfo()
        }
    }
    
    func changeRootToLogin() {
        let backToLogin : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = backToLogin.instantiateViewController(withIdentifier: "Login") as! LoginVC
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false, completion: nil)
        //        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
        //        window.rootViewController = viewController
        //        window.makeKeyAndVisible()
        //
//        let storyborad = UIStoryboard(name: "Main", bundle: nil)
//        if let vc = storyborad.instantiateViewController(withIdentifier: "Login") as? LoginVC {
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        
    }
    
    func signOutUser() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

