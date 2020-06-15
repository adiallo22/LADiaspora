//
//  NewPostVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/14/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SDWebImage

class NewPostVC: UIViewController {
    
    @IBOutlet weak var newPostBtn: UIButton!
    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var captiontf: UITextField!
    
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
    
    @IBAction func cancelClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newPostClicked(_ sender: UIButton) {
        guard let caption = captiontf.text else { return }
        PostService.shared.uploadPostToDB(caption: caption) { (error, db) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

//MARK: - helpers

extension NewPostVC {
    
    func configureUI() {
        newPostBtn.roundButton(withColor: .orange)
        cancelBtn.roundButton(withColor: .lightGray)
        setProfileImage()
    }
    
    func setProfileImage() {
        guard let profileURL = user?.profileURL else { return }
        guard let url = URL.init(string: profileURL) else { return }
        profileIMG.sd_setImage(with: url, completed: nil)
        profileIMG.layer.cornerRadius = profileIMG.layer.frame.height / 2.0
        profileIMG.layer.masksToBounds = true
    }
    
}
