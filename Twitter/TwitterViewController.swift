//
//  ViewController.swift
//  Twitter
//
//  Created by Ping Zhang on 11/3/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import UIKit
import SnapKit

class TwitterViewController: UIViewController {

    private var _tableView: UITableView!
    private var _signOutButton: UIBarButtonItem!
    private var _newTwitterButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addLayouts()
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = signOutButton
        navigationItem.rightBarButtonItem = newTwitterButton
    }
    
    func addLayouts() {
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(snp_topLayoutGuideBottom)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
        }
    }
    

    func didPressSignOutButton() {
        User.clearCurrentUser()
        dismissViewControllerAnimated(true, completion: nil)
        print("didPressSignOutButton")
    }
    
    func didPressNewTwitterButton() {
        print("didPressNewTwitterButton")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TwitterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseId = "TwitterTableViewCell"
        let cell: TwitterTableViewCell
        if let reuseCell = tableView.dequeueReusableCellWithIdentifier(reuseId) as? TwitterTableViewCell {
            cell = reuseCell
        }
        else {
            cell = TwitterTableViewCell(style: .Subtitle, reuseIdentifier: reuseId)
        }
        
        
        return cell
    }
    
    
}

extension TwitterViewController {
    var tableView: UITableView {
        if _tableView == nil {
            let tempTableView = UITableView()
            tempTableView.delegate = self
            tempTableView.dataSource = self
            tempTableView.estimatedRowHeight = 200
            tempTableView.rowHeight = UITableViewAutomaticDimension
            _tableView = tempTableView
        }
        return _tableView
    }
    
    var signOutButton: UIBarButtonItem {
        if _signOutButton == nil {
            let tempSignOutButton = UIBarButtonItem(title: "Sign Out", style: .Plain, target: self, action: "didPressSignOutButton")
            _signOutButton = tempSignOutButton
        }
        return _signOutButton
    }
    
    var newTwitterButton: UIBarButtonItem {
        if _newTwitterButton == nil {
            let tempNewTwitterButton = UIBarButtonItem(title: "New", style: .Plain, target: self, action: "didPressNewTwitterButton")
            _signOutButton = tempNewTwitterButton
        }
        return _signOutButton
    }
}