//
//  PostTVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/15/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SDWebImage

protocol HandPostDelegate {
    func profileImageTapped(_ cell: PostTVC)
    func handleReplyPost(_ cell: PostTVC)
    func handleSharedPost(_ cell: PostTVC)
    func handleLikepost(_ cell: PostTVC)
}

class PostTVC: UITableViewCell {

    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var fullnametf: UILabel!
    @IBOutlet weak var timestamptf: UILabel!
    @IBOutlet weak var captiontf: UILabel!
    @IBOutlet weak var usernametf: UILabel!
    
    var post : Post? {
        didSet { config() }
    }
    
    var tappedDelegate : HandPostDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileIMG.roundView()
        makeProfileIMGTappable()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        tappedDelegate?.handleLikepost(self)
    }
    
    @IBAction func replyButtonPressed(_ sender: UIButton) {
        tappedDelegate?.handleReplyPost(self)
    }
    
    @IBAction func repostButtonPressed(_ sender: UIButton) {
        print("reposted..")
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        tappedDelegate?.handleSharedPost(self)
    }

}

//MARK: - helpers

extension PostTVC {
    
    func config() {
        guard let post = post else { return }
        let postVM = PostViewModel.init(post: post)
        fullnametf.text = postVM.fullname
        usernametf.text = "@\(postVM.username)"
        captiontf.text = post.caption
        guard let url = URL.init(string: postVM.profileURL) else { return }
        profileIMG.sd_setImage(with: url, completed: nil)
        timestamptf.text = "\(postVM.timestamp) ago"
    }
    
    func makeProfileIMGTappable() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(profileTapped))
        profileIMG.addGestureRecognizer(tap)
        profileIMG.isUserInteractionEnabled = true
    }
    
    @objc func profileTapped() {
        tappedDelegate?.profileImageTapped(self)
    }
    
}
