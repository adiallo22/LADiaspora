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
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var replyLabel: UILabel!
    
    var config : uploadPostCongig? {
        didSet { print("config chosen") }
    }
    private lazy var viewModel = UploadPostViewModel.init(config: config!)
    
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
        
//        switch config {
//        case .post:
//            captiontf.placeholder = "what's on your mind?"
//            newPostBtn.setTitle("\(viewModel.actionButton)", for: .normal)
//        case .reply(let post):
//            captiontf.placeholder = "replying to post @\(post.user.username)"
//            newPostBtn.setTitle("Reply", for: .normal)
//        case .none:
//            print("config has not been set up yet")
//        }
        
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
        captiontf.becomeFirstResponder()
//        captiontf.scroll
        newPostBtn.roundButton(withColor: .orange)
        cancelBtn.roundButton(withColor: .lightGray)
        setProfileImage()
        stack.alignment = .leading
        //
        newPostBtn.setTitle(viewModel.actionButton, for: .normal)
        captiontf.placeholder = viewModel.placeholder
        replyLabel.isHidden = !viewModel.shouldShowReplyLabel
        replyLabel.text = viewModel.replyLabel
    }
    
    func setProfileImage() {
        guard let profileURL = user?.profileURL else { return }
        guard let url = URL.init(string: profileURL) else { return }
        profileIMG.sd_setImage(with: url, completed: nil)
        profileIMG.roundView()
    }
    
}
