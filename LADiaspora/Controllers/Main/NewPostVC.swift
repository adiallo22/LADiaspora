//
//  NewPostVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/14/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class NewPostVC: UIViewController {
    
    @IBOutlet weak var newPostBtn: UIButton!
    @IBOutlet weak var profileIMG: UIImageView!
    
    var user : User?
    
//    init(user: User) {
//        self.user = user
//        super.init(nibName: nil, bundle: nil)
//        print(user.uid)
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    @IBAction func newPostClicked(_ sender: UIButton) {
    }
    
}

//MARK: - helpers

extension NewPostVC {
    
    func configureUI() {
        newPostBtn.roundButton(withColor: .orange)
    }
    
}
