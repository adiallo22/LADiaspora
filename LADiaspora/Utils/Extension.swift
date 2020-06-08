//
//  Extension.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func setNewPostButton () {
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = self.layer.frame.height / 2.0
        self.layer.masksToBounds = true
    }
    
}

