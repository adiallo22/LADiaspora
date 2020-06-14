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
    
    func roundButton(withColor color : UIColor) {
        self.layer.cornerRadius = self.frame.height / 2.0
        self.backgroundColor = color
        self.tintColor = .white
    }
    
}

//MARK: - <#section heading#>

extension UITextField {
    
    func underlineText() {
        let line = CALayer()
        line.backgroundColor = CGColor.init(srgbRed: 0, green: 0, blue: 0, alpha: 1.0)
        line.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width - 20, height: 0.75)
        self.borderStyle = .none
        self.layer.addSublayer(line)
    }
}


