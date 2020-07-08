//
//  NotificationCell.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/8/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.roundView()
        profileImage.backgroundColor = .orange
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
