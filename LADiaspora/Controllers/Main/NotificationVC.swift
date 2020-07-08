//
//  NotificationVC.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import Firebase

class NotificationVC: UIViewController {

    @IBOutlet weak var newPostButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var notifications = [Notification]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 60
        
    }

    @IBAction func newPostClicked(_ sender: UIButton) {
        print("new post clicked..")
    }
    
}

//MARK: - Helpers

extension NotificationVC {
    
    func configureUI() {
        navigationItem.title = Constants.Titles.notification
        newPostButton.setNewPostButton()
    }
    
    
}

//MARK: - datasource and delegate

extension NotificationVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected..")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.notificationCell) as! NotificationCell
        return cell
    }
}

