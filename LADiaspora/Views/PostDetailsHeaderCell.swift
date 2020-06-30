//
//  PostDetailsHeaderCell.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/29/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class PostDetailsHeaderCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    
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
        print("action button pressed..")
    }
    
}

//MARK: -

extension PostDetailsHeaderCell {
    
    func configUI() {
        profileImage.roundView()
        profileImage.backgroundColor = .orange
    }
    
    func makeProfileIMGTappable() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(profileTapped))
        profileImage.addGestureRecognizer(tap)
        profileImage.isUserInteractionEnabled = true
    }
    
    @objc func profileTapped() {
        print("profile tapped..")
    }
    
}
