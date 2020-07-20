//
//  HeaderViewEdit.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/20/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class HeaderViewEdit : UIView {
    
    private let user : User
    
    let profileIMG : UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = .orange
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -  helpers
    
    func configUI() {
        profileIMG.roundView()
        profileIMG.frame.size.width = 100
        profileIMG.frame.size.height = 100
        addSubview(profileIMG)
        addSubview(cButton)
//        cButton.cen
    }
    
    @objc func changeProfileTapped() {
        print("clicked..")
    }
    
}
