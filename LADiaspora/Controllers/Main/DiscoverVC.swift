//
//  DiscoverVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class DiscoverVC: UIViewController {

    @IBOutlet weak var newPostButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    @IBAction func newPostClicked(_ sender: UIButton) {
    }
    
}

//MARK: - Helpers

extension DiscoverVC {
    
    func configureUI() {
        navigationItem.title = Constants.Titles.discover
        newPostButton.setNewPostButton()
    }
    
}

