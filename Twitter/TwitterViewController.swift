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
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addLayouts()
    }
    
    override func viewWillAppear(animated: Bool) {
        initData()
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = signOutButton
        navigationItem.rightBarButtonItem = newTwitterButton
        
        refreshControl.tintColor = UIColor.grayColor()
        refreshControl.addTarget(self, action: "refreshView", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
    }
    

    
    func addLayouts() {
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view)
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
    
    func initData() {
        if let currentUser = User.currentUser() {
            let parameters =  Dictionary<String, AnyObject>()
            currentUser.get(TwitterHost + "/statuses/home_timeline.json", parameters: parameters,
                success: {
                    data, response in
                    
                    let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    print(json)
                }, failure: {(error:NSError!) -> Void in
                    print(error)
            })
        }
    }
    
    func refreshView() {
        refreshControl.beginRefreshing()
        initData()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TwitterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        
        cell.profileImageView.image = UIImage(named: "twitterProfile.png")
        cell.nameLabel.text = "Ping Zhang"
        cell.usernameLabel.text = "@pzhang"
        cell.twitterTime.text = "4h"
        cell.twitterContent.text = "fasfdasfdsafdasfffffffffffffffffffffffffffsadfsafdsafasdfasdfsafdsafasdfsdfasfdsafsdfsafasdfasdsadasdfefawefsjfsfl"
        
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