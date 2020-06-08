//
//  Util.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

struct Util {
    
    func designThetextfield(withTextField textfield : UITextField) {
        let line = CALayer()
//        line.backgroundColor = CGColor.init(srgbRed: 0, green: 0, blue: 0, alpha: 1.0)
//        line.frame = CGRect(x: 0, y: textfield.frame.size.height, width: textfield.frame.size.width, height: 1)
        textfield.borderStyle = .none
        textfield.layer.addSublayer(line)
        
    }
    
    func roundButton(withButton button : UIButton) {
        button.layer.cornerRadius = button.frame.height / 2.0
        button.backgroundColor = .black
        button.tintColor = .white
    }
    
}
