//
//  HeaderViewEdit.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/20/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SnapKit

protocol EditProfileDelegate: class {
    func passEditClicked()
}

class HeaderViewEdit : UIView {
    
    private let user : User
    
    weak var delegate : EditProfileDelegate?
    
    let profileIMG : UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let cButton : UIButton = {
        let view = UIButton()
        view.setTitle("Change profile image", for: .normal)
        view.addTarget(self, action: #selector(changeProfileTapped), for: .touchUpInside)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        view.setTitleColor(.white, for: .normal)
        return view
    }()
    
    //MARK: - init
    
    init(user: User) {
        self.user = user
        super.init(frame: .zero)
        backgroundColor = .orange
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -  helpers
    
    fileprivate func configUI() {
        addSubview(profileIMG)
        profileIMG.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(90)
            make.centerY.equalTo(self.snp.centerY).offset(-16)
            make.centerX.equalTo(self.snp.centerX)
            
        }
        profileIMG.layer.cornerRadius = profileIMG.frame.width / 2.0
        profileIMG.layer.masksToBounds = true
        guard let url = URL.init(string: user.profileURL) else { return }
        profileIMG.sd_setImage(with: url, completed: nil)
        //
        addSubview(cButton)
        cButton.snp.makeConstraints { make in
            make.bottom.equalTo(profileIMG).offset(20)
            make.centerX.equalTo(self.snp.centerX)
        }
        
    }
    
    @objc func changeProfileTapped() {
        delegate?.passEditClicked()
//        print("clicked..")
    }
    
}
