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
    private let refreshControl = UIRefreshControl()
    private var twitters: [TwitterContent] = []
    
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
        
        let newTwitterPage = NewTwitterViewController()
        
        newTwitterPage.username = "pzhang"
        newTwitterPage.profileImageUrl = "http://pbs.twimg.com/profile_images/1296339574/foxnews-avatar_normal.png"
        newTwitterPage.name = "Ping Zhang"
        
        let newTwitterPageNav = TwitterNavigationViewController(rootViewController: newTwitterPage)
        presentViewController(newTwitterPageNav, animated: true, completion: nil)
    }
    
    func initData() {
        if let currentUser = User.currentUser() {
            let parameters =  Dictionary<String, AnyObject>()
            currentUser.get(TwitterHost + "/statuses/home_timeline.json", parameters: parameters,
                success: {
                    data, response in
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                        var loadedTwitters: [TwitterContent] = []
                        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                        for twitter in json! {
                            let user = twitter["user"] as! NSDictionary
                            
                            let profileImageUrl = user["profile_image_url"] as! String
                            let twitterText = twitter["text"] as! String
                            
                            let twitteredData = twitter["created_at"] as! String
                            let dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
                            let date = dateFormatter.dateFromString(twitteredData)
                            
                            let loadedTwitter = TwitterContent(
                                name: user["name"] as! String,
                                username: ("@" + (user["screen_name"] as! String)),
                                twitterTime: "4h",
                                twitterContent: twitterText,
                                profileImageUrl: profileImageUrl
                            )
                            loadedTwitters.append(loadedTwitter)
                        }
                        
                        let lastCount = self.twitters.count
                        self.twitters.appendContentsOf(loadedTwitters)
                        let indexPaths = (lastCount..<self.twitters.count).map { NSIndexPath(forItem: $0, inSection: 0) }
                        dispatch_async(dispatch_get_main_queue()) {
                            self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Bottom)
                        }
                    }
                }, failure: {(error: NSError!) -> Void in
                    TwitterHelper.sendAlert("Failure", message: error.localizedDescription)

            })
        }
    }
    
    func refreshView() {
        refreshControl.beginRefreshing()
        //twitters = []
        tableView.reloadData()
        //initData()
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TwitterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twitters.count
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
        let twitter = twitters[indexPath.row]
        cell.setTwitter(twitter)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedTwitter = twitters[indexPath.row]
        let twitterDetail = TwitterDetailViewController()
        twitterDetail.selectedTwitter = selectedTwitter
        
        self.navigationController?.pushViewController(twitterDetail, animated: true)
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