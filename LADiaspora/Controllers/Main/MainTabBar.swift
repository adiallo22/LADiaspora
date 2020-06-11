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

    override func viewDidLoad() {
        super.viewDidLoad()
        //signOutUser()
        checkUserLog()
    }
    
    func checkUserLog() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let main : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = main.instantiateViewController(withIdentifier: "Login") as! LoginVC
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        } else {
            print("a user is logged in")
        }
    }
    
    func signOutUser() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }

}

