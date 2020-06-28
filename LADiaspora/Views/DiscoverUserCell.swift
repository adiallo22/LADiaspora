//
//  DiscoverUserCell.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/28/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SDWebImage

class DiscoverUserCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fulllname: UILabel!
    @IBOutlet weak var username: UILabel!
    
    var user : User? {
        didSet {
            configUser()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configUI() {
        profileImage.roundView()
        profileImage.backgroundColor = .orange
    }
    
    func configUser() {
        guard let user = user else { return }
        guard let url = URL(string: user.profileURL) else { return }
        profileImage.sd_setImage(with: url, completed: nil)
        fulllname.text = user.fullname
        username.text = user.username
    }

}
