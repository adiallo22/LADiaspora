//
//  PostDetailsHeaderCell.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/29/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SDWebImage

protocol ActionSheetHandler: class {
    func actionSheetTapped()
}

class PostDetailsHeaderCell: UITableViewCell {
    
    var post : Post? {
        didSet {
            configPost()
        }
    }
    
    weak var actionDelegate : ActionSheetHandler?

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var repostCount: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        makeProfileIMGTappable()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        actionDelegate?.actionSheetTapped()
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        print("like button pressed..")
    }
    
    
}

//MARK: -

extension PostDetailsHeaderCell {
    
    func configUI() {
        profileImage.roundView()
    }
    
    func makeProfileIMGTappable() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(profileTapped))
        profileImage.addGestureRecognizer(tap)
        profileImage.isUserInteractionEnabled = true
    }
    
    @objc func profileTapped() {
        print("profile tapped..")
    }
    
    func configPost() {
        guard let post = post else { return }
        let viewModel = PostViewModel.init(post: post)
        fullname.text = viewModel.fullname
        username.text = "@\(viewModel.username)"
        timestamp.text = viewModel.secondTimestamp
        postLabel.text = viewModel.caption
        guard let url = URL.init(string: viewModel.profileURL) else { return }
        profileImage.sd_setImage(with: url, completed: nil)
        likesCount.text = viewModel.numberOfLikes
        repostCount.text = viewModel.numberOfRepost
        likeButton.imageView?.image = viewModel.likeImage
        likeButton.tintColor = viewModel.likeColor
    }
    
}
