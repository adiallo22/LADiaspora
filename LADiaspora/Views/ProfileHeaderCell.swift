//
//  ProfileHeaderCell.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/24/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

protocol HandleFollowUser: class {
    func followBtnTapped(_ to: ProfileHeaderCell)
    func delegateFilterPicked(_ option: FilterOptions)
}

class ProfileHeaderCell: UITableViewCell {
    
    var user : User? {
        didSet { configUser() }
    }
    
    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var fullnametf: UILabel!
    @IBOutlet weak var usernametf: UILabel!
    @IBOutlet weak var biotf: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    
    weak var followDelegate : HandleFollowUser?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        //
        configUI()
        //
        let selectedItem = IndexPath.init(row: 0, section: 0)
        collectionView.selectItem(at: selectedItem, animated: true, scrollPosition: .left)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func followTapped(_ sender: UIButton) {
        followDelegate?.followBtnTapped(self)
//        guard let user = user else { return }
//        if user.isFollowed == false {
//            UserService.shared.followUser(uid: user.uid) { [weak self] (error, ref) in
//                self?.user?.isFollowed = true
//                self?.followBtn.setTitle("Unfollow", for: .normal)
//            }
//        } else {
//            UserService.shared.unfollowUser(uid: user.uid) { [weak self] (error, ref) in
//                self?.user?.isFollowed = false
//                self?.followBtn.setTitle("Follow", for: .normal)
//            }
//        }
    }

}

//MARK: - helpers

extension ProfileHeaderCell {
    
    func configUI() {
        profileIMG.roundView()
        profileIMG.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        profileIMG.layer.borderWidth = 1
        //
        biotf.text = "I am Abdul and I am an iOS Developer and investor. I am extremely motivated to succeed for my family, my wife and my self"
        //
        followBtn.roundButton(withColor: .orange)
        followBtn.layer.borderWidth = 1
        followBtn.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func configUser() {
        guard let user = user else { return }
        let viewModel = ProfileHeaderVM.init(user: user)
        followers.text = viewModel.followers
        following.text = viewModel.following
        followBtn.setTitle(viewModel.profileBtnTitle, for: .normal)
        profileIMG.sd_setImage(with: viewModel.url, completed: nil)
        fullnametf.text = viewModel.fullname
        usernametf.text = viewModel.username
    }
    
}


//MARK: - delegate, datasource and flowlayout

extension ProfileHeaderCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FilterOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.filterCell, for: indexPath) as! FilterCell
        let option = FilterOptions.init(rawValue: indexPath.row)
        cell.option = option
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let option = FilterOptions.init(rawValue: indexPath.row) else { return }
        followDelegate?.delegateFilterPicked(option)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: frame.width / 3, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

