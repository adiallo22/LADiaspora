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
    
    //MARK: - init
    
    init(user: User) {
        self.user = user
        super.init(frame: .zero)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
