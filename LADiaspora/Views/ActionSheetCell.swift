//
//  ActionSheetCell.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/2/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class ActionSheetCell: UITableViewCell {
    
    private var optionImage : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = #imageLiteral(resourceName: "follow")
        return view
    }()
    
    private let title : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "follow"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(optionImage)
        optionImage.frame.size.width = 36
        optionImage.frame.size.height = 36
        title.textColor = .orange
        addSubview(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers

extension ActionSheetCell {
    
    
    
}
