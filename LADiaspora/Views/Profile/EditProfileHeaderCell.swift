//
//  EditProfileHeaderCell.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/17/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class EditProfileHeaderCell: UITableViewCell {
    
    @IBOutlet weak var profileIMG: UIImageView!
    
    var user : User? {
        didSet {
            configUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .orange
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeSelected(_ sender: UIButton) {
        print("selected..")
    }
    
}

//MARK: - helpers

extension EditProfileHeaderCell {
    
    func configUI() {
        guard let user = user else { return }
        guard let url = URL.init(string: user.profileURL) else { return }
        profileIMG.roundView()
        profileIMG.sd_setImage(with: url, completed: nil)
    }
    
}
