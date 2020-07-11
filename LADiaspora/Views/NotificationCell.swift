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
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    var notification : Notification? {
        didSet {
            configNotification()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK: - helpers

extension NotificationCell {
    
    func configUI() {
        profileImage.roundView()
        profileImage.backgroundColor = .orange
    }
    
    func configNotification() {
        print("notification received..")
    }
    
}
