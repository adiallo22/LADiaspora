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
