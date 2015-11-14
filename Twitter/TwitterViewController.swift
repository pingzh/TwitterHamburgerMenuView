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
    
    private var _menuView: UIView!
    private var _contentView: UIView!
    
    private var _panGesture: UIPanGestureRecognizer!
    
    var myAccountViewController: UIViewController!  {
        didSet {
            view.layoutIfNeeded()
            menuView.addSubview(myAccountViewController.view)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addLayouts()
    }
    
    override func viewWillAppear(animated: Bool) {
        initData()
    }
    
    func addSubviews() {
        view.backgroundColor = UIColor.lightGrayColor()
        
        view.addSubview(menuView)
        view.addSubview(contentView)
        
        contentView.addSubview(tableView)
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = signOutButton
        navigationItem.rightBarButtonItem = newTwitterButton
        
        refreshControl.tintColor = UIColor.grayColor()
        refreshControl.addTarget(self, action: "refreshView", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func addLayouts() {
        
        menuView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        contentView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }

        contentView.addGestureRecognizer(panGesture)
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(NavHeight)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.bottom.equalTo(contentView)
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
    
    func onPanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
        
        }
        else if sender.state == UIGestureRecognizerState.Changed {
//            contentView.snp_updateConstraints(closure: { (make) -> Void in
//                make.left.equalTo(view).offset(translation.x)
//            })
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.3, animations: {
                if velocity.x > 0 {
                    self.contentView.snp_updateConstraints(closure: { (make) -> Void in
                        make.left.equalTo(self.view).offset(TWMenuWidth)
                    })
                }
                else {
                    self.contentView.snp_updateConstraints(closure: { (make) -> Void in
                        make.left.equalTo(self.view).offset(0)
                    })
                }
            })
        }
    }
    func initData() {
        getHomeTimeline()
    }
    
    
    func getHomeTimeline() {
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
                            let profileBannerImageUrl = "" //user["profile_banner_url"] as? String
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
                                profileImageUrl: profileImageUrl,
                                profileBannerImageUrl: profileBannerImageUrl,
                                twitters: user["listed_count"] as! Int,
                                followings: user["following"] as! Int,
                                followers: user["followers_count"] as! Int
                                
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
        
        cell.selectionStyle = .None
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        cell.profileImageView.tag = indexPath.row
        cell.profileImageView.addGestureRecognizer(tapGestureRecognizer)
        
        return cell
    }
    
    func imageTapped(sender: AnyObject) {
        let profilePageController = ProfiePageViewController()
        let profileImage = sender.view as! UIImageView
        profilePageController.selectedUser = twitters[profileImage.tag]
        self.navigationController?.pushViewController(profilePageController, animated: true)
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
    
    var menuView: UIView {
        if _menuView == nil {
            _menuView = UIView()
            _menuView.backgroundColor = UIColor.blueColor()
            
        }
        return _menuView
    }
    
    var contentView: UIView {
        if _contentView == nil {
            _contentView = UIView()
            _contentView.backgroundColor = UIColor.whiteColor()
        }
        return _contentView
    }
    
    var panGesture: UIPanGestureRecognizer {
        if _panGesture == nil {
            _panGesture = UIPanGestureRecognizer(target: self, action: "onPanGesture:")
        }
        return _panGesture
    }
    
}