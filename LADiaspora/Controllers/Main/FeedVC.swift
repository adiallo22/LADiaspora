//
//  FeedVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var newPostButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    @IBAction func newPostClicked(_ sender: UIButton) {
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
    
}
