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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .orange
        configUI()
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
        profileIMG.roundView()
        profileIMG.backgroundColor = .white
    }
    
}
