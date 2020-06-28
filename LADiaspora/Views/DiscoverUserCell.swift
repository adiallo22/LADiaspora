//
//  DiscoverUserCell.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/28/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class DiscoverUserCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fulllname: UILabel!
    @IBOutlet weak var username: UILabel!
    
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

}
