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
    
}

//MARK: - helpers

extension ActionSheet {
    
    func presentActionSheet() {
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
        self.window = window
        tableView.frame = CGRect.init(x: 0, y: window.frame.height - 300, width: window.frame.width, height: 300)
        window.addSubview(tableView)
        print("actionsheet presented..")
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
        tableView.isScrollEnabled = false
    }
    
}


//MARK: - delegation & datasource

extension ActionSheet : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        cell?.textLabel?.text = "test"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
}
