//
//  EditDetaiCell.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/17/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

protocol EditDelegate : class {
    func didFinishEditingText(_ cell: EditDetaiCell)
}

class EditDetaiCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var tf: UITextField!
    
    weak var delegate : EditDelegate?
    
    var option : EditProfilOptions? {
        didSet {
            configUI()
        }
    }
    
    var user : User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        editTextField()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK: - helpers

extension EditDetaiCell {
    
    func editTextField() {
        tf.addTarget(self, action: #selector(didFinishEdit), for: .editingDidEnd)
    }
    
    @objc func didFinishEdit() {
        delegate?.didFinishEditingText(self)
    }
    
    func configUI() {
        guard let option = option else { return }
        guard let user = user else { return }
        let viewModel = EditProfileViewModel.init(user: user, option: option)
        optionLabel.text = viewModel.titleText
        tf.text = viewModel.optionVal
    }
    
}
