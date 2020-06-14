//
//  FeedVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SDWebImage

class FeedVC: UIViewController {
    
    var user : User? {
        didSet {
            print("got it")
//            invokeUserProfileIMG()
        }
    }

    @IBOutlet weak var newPostButton: UIButton!
    @IBOutlet weak var profileIMGButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    @IBAction func newPostClicked(_ sender: UIButton) {
//        let newPostNav = UINavigationController.init(rootViewController: NewPostVC())
//        newPostNav.modalPresentationStyle = .fullScreen
//        present(newPostNav, animated: false, completion: nil)
        performSegue(withIdentifier: "toNewPost", sender: self)
    }
    

}

//MARK: - Helpers

extension FeedVC {
    
    func configureUI() {
//        let navImage = UIImageView.init(image: UIImage(named: "diaspora"))
//        navigationItem.titleView = navImage
        navigationItem.title = "Home"
        newPostButton.setNewPostButton()
        
    }
    
    func invokeUserProfileIMG() {
        guard let imageURL = user?.profileURL else { return }
        guard let url = URL.init(string: imageURL) else { return }
        let profileIMGView = UIImageView.init()
        profileIMGView.frame = CGRect.init(x: 0, y: 0, width: 32, height: 32)
        profileIMGView.layer.cornerRadius = profileIMGView.layer.frame.width / 2.0
        profileIMGView.layer.masksToBounds = true
        profileIMGView.sd_setImage(with: url, completed: nil)
        navigationItem.leftBarButtonItem?.customView = profileIMGView
    }
    
}
