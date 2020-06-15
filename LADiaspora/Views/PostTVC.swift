//
//  PostTVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/15/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SDWebImage

class PostTVC: UITableViewCell {

    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var fullnametf: UILabel!
    @IBOutlet weak var timestamptf: UILabel!
    @IBOutlet weak var captiontf: UILabel!
    
    var post : Post? {
        didSet { config() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileIMG.roundView()
        captiontf.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config() {
        guard let post = post else { return }
        fullnametf.text = "\(post.user.fullname) @\(post.user.username)"
        captiontf.text = post.caption
        guard let url = URL.init(string: post.user.profileURL) else { return }
        profileIMG.sd_setImage(with: url, completed: nil)
        timestamptf.text = "15s"
    }

}
