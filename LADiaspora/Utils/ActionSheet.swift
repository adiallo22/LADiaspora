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
    
}

//MARK: - helpers

extension ActionSheet {
    
    func presentActionSheet() {
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
        self.window = window
        tableView.frame = CGRect.init(x: 0, y: window.frame.height, width: window.frame.width, height: 300)
        fadedView.frame = window.frame
        window.addSubview(fadedView)
        window.addSubview(tableView)
        UIView.animate(withDuration: 0.5) {
            self.fadedView.alpha = 1
            self.tableView.frame.origin.y -= 300
        }
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        //
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 60
        tableView.backgroundColor = .orange
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 8
        tableView.layer.masksToBounds = true
        tableView.isScrollEnabled = false
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
}
