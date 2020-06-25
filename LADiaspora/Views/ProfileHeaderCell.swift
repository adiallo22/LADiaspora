//
//  ProfileHeaderCell.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/24/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {
    
    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var fullnametf: UILabel!
    @IBOutlet weak var usernametf: UILabel!
    @IBOutlet weak var biotf: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        //
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configUI() {
        profileIMG.roundView()
        profileIMG.backgroundColor = .orange
        profileIMG.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        profileIMG.layer.borderWidth = 1
        //
        fullnametf.text = "Abdul Diallo"
        usernametf.text = "@"+"abduldiallo196"
        biotf.text = "I am Abdul and I am an iOS Developer and investor. I am extremely motivated to succeed for my family, my wife and my self"
        //
        followBtn.roundButton(withColor: .orange)
        followBtn.layer.borderWidth = 1
        followBtn.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
    }

}


//MARK: - delegate, datasource and flowlayout

extension ProfileHeaderCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.filterCell, for: indexPath) as! FilterCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterCell else { return }
//        UIView.animate(withDuration: 0.3) {
//            cell.underLine.layer.frame.origin.x = cell.frame.origin.x
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: frame.width / 3, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

