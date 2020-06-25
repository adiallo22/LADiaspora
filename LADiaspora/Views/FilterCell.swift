//
//  FilterCell.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/25/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    @IBOutlet weak var filterTitle: UILabel!
    @IBOutlet weak var underLine: UIView!
    
    override var isSelected: Bool {
        didSet {
            filterTitle.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            filterTitle.textColor = isSelected ? .orange : .lightGray
            underLine.backgroundColor = isSelected ? .orange : .white
        }
    }
    
}
