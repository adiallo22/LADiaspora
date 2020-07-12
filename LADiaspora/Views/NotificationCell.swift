//
//  NotificationCell.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/8/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

protocol NotificationCellDelegate : class {
    func handleProfileTaped(_ cell: NotificationCell)
}

class NotificationCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var types: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    var notification : Notification? {
        didSet {
            configNotification()
        }
    }
    
    weak var delegate : NotificationCellDelegate?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK: - helpers

extension NotificationCell {
    
    func configUI() {
        profileImage.roundView()
    }
    
    func configNotification() {
        guard let notification = notification else { return }
        let viewModel = NotificationViewModel.init(notification: notification)
        guard let url = URL.init(string: viewModel.imageURL) else { return }
        profileImage.sd_setImage(with: url, completed: nil)
        message.text = viewModel.username
        types.text = viewModel.message
        time.text = "\(viewModel.timestamp) ago"
    }
    
    func makeGestureRecognizer() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(profileTaped))
        profileImage.addGestureRecognizer(tap)
        profileImage.isUserInteractionEnabled = true
    }
    
    @objc func profileTaped() {
        delegate?.handleProfileTaped(self)
    }
    
}
