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
        performSegue(withIdentifier: Constants.Segues.toNewPost, sender: self)
        //segue programatically
//        let storyborad = UIStoryboard(name: "Main", bundle: nil)
//        if let vc = storyborad.instantiateViewController(withIdentifier: "NewPostVC") as? NewPostVC {
//             self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    

}

//MARK: - Helpers

extension FeedVC {
    
    func configureUI() {
        navigationItem.title = Constants.Titles.home
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

//MARK: - segues

extension FeedVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.Segues.toNewPost {
            let destVC = segue.destination as! NewPostVC
            guard let usr = user else { return }
            destVC.user = usr
        }
        
    }
    
}
