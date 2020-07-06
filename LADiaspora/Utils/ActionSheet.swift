//
//  ActionSheet.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 7/2/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

private let cellIdentifier = "actionCell"

class ActionSheet : NSObject {
    
    private let user : User
    private let tableView = UITableView()
    private lazy var viewModel = ActionSheetViewModel(user: user)
    
    var window : UIWindow?
    
    init(user: User) {
        self.user = user
        super.init()
        //
        configTableView()
    }
    
    //MARK: - <#section heading#>
    
    private lazy var fadedView : UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        //
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(handleDismiss))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = .orange
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    private let footer : UIView = {
        let view = UIView()
//        view.addSubview(cancelButton)
        view.layer.cornerRadius = view.frame.size.width / 2.0
//        view.centerYAnchor = view.constraints
        return view
    }()
    
}

//MARK: - helpers

extension ActionSheet {
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        //
        tableView.register(ActionSheetCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 8
        tableView.layer.masksToBounds = true
        tableView.isScrollEnabled = false
    }
    
    func presentActionSheet() {
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
        self.window = window
        let height = tableView.rowHeight * CGFloat(viewModel.options.count) + 100
        tableView.frame = CGRect.init(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        fadedView.frame = window.frame
        window.addSubview(fadedView)
        window.addSubview(tableView)
        UIView.animate(withDuration: 0.5) {
            self.fadedView.alpha = 1
            self.tableView.frame.origin.y -= height
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.tableView.frame.origin.y += 300
            self.fadedView.alpha = 0
        }
    }
}


//MARK: - delegation & datasource

extension ActionSheet : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ActionSheetCell
        cell.option = viewModel.options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.options[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footer
    }
}
