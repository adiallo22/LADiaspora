//
//  PostTVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/15/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class PostTVC: UITableViewCell {

    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var fullnametf: UILabel!
    @IBOutlet weak var timestamptf: UILabel!
    @IBOutlet weak var captiontf: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileIMG.roundView()
        captiontf.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
