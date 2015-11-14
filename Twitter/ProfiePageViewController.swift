//
//  ProfiePageViewController.swift
//  Twitter
//
//  Created by Ping Zhang on 11/14/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import UIKit

class ProfiePageViewController: UIViewController {
    
    private var _profileBannerImageView: UIImageView!
    private var _profileImageView: UIImageView!
    private var _nameLabel: UILabel!
    private var _usernameLabel: UILabel!
    private var _twitterNumer: UIButton!
    private var _followingNumer: UIButton!
    private var _followerNumber: UIButton!
    private var _tableView: UITableView!
    
    var selectedUser: TwitterContent!
    private var twitters: [TwitterContent] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addLayout()
        initData()
    }
    
    func addSubviews() {
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(profileBannerImageView)
        
        profileBannerImageView.addSubview(profileImageView)
        profileBannerImageView.addSubview(nameLabel)
        profileBannerImageView.addSubview(usernameLabel)
        
        view.addSubview(twitterNumer)
        view.addSubview(followingNumer)
        view.addSubview(followerNumber)
        
        view.addSubview(tableView)
    }
    
    func addLayout() {
        profileBannerImageView.image = UIImage(named: "blur_bg.jpg")//user["profile_banner_url"] as! String
        profileBannerImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(NavHeight)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.height.equalTo(TProfileImageHeight * 3)
        }
        
        profileImageView.image = UIImage(named: "twitterProfile.png")
        profileImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(profileBannerImageView).offset(16)
            make.centerX.equalTo(profileBannerImageView)
            make.height.equalTo(TProfileImageHeight)
            make.width.equalTo(TProfileImageHeight)
        }
        
        nameLabel.text = "pingzhang"
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(profileImageView.snp_bottom).offset(8)
            make.centerX.equalTo(profileImageView)
        }
        usernameLabel.text = "@pingzh"
        usernameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp_bottom).offset(8)
            make.centerX.equalTo(profileImageView)
        }
        
        //twitterNumer.backgroundColor = UIColor.blueColor()
        twitterNumer.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(profileBannerImageView.snp_bottom).offset(0)
            make.left.equalTo(profileBannerImageView).offset(0)
            make.width.equalTo(screenWidth / 3)
            make.height.equalTo(40)
        }
        
        //followerNumber.backgroundColor = UIColor.blueColor()
        followerNumber.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(profileBannerImageView.snp_bottom).offset(0)
            make.right.equalTo(profileBannerImageView.snp_right).offset(0)
            make.width.equalTo(screenWidth / 3)
            make.height.equalTo(40)
        }
        
        //followingNumer.backgroundColor = UIColor.blueColor()
        followingNumer.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(profileBannerImageView.snp_bottom).offset(0)
            make.left.equalTo(twitterNumer.snp_right).offset(0)
            make.right.equalTo(followerNumber.snp_left).offset(-0)
            make.height.equalTo(40)
        }
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(followingNumer.snp_bottom).offset(0)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    func initData(){
        getHomeTimeline()
        
        let profileImageUrl = NSURL(string: selectedUser.profileImageUrl)
        profileImageView.af_setImageWithURL(profileImageUrl!)
        
        nameLabel.text = selectedUser.name
        usernameLabel.text = selectedUser.username
        twitterNumer.setTitle(selectedUser.twitters.description + "\nTWITTERS", forState: .Normal)
        followingNumer.setTitle(selectedUser.followings.description + "\nFOLLOWING", forState: .Normal)
        followerNumber.setTitle(selectedUser.followers.description + "\nFOLLOWERS", forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getHomeTimeline() {
        if let currentUser = User.currentUser() {
            let parameters =  ["screen_name": selectedUser.username]
            currentUser.get(TwitterHost + "/statuses/user_timeline.json", parameters: parameters,
                success: {
                    data, response in
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                        var loadedTwitters: [TwitterContent] = []
                        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                        for twitter in json! {
                            let user = twitter["user"] as! NSDictionary
                            
                            let profileImageUrl = user["profile_image_url"] as! String
                            let profileBannerImageUrl = ""//user["profile_banner_url"] as? String

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
}

extension ProfiePageViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedTwitter = twitters[indexPath.row]
        let twitterDetail = TwitterDetailViewController()
        twitterDetail.selectedTwitter = selectedTwitter
        
        self.navigationController?.pushViewController(twitterDetail, animated: true)
    }
}

extension ProfiePageViewController {
    var profileBannerImageView: UIImageView {
        if _profileBannerImageView == nil {
            _profileBannerImageView = UIImageView()
        }
        return _profileBannerImageView
    }
    
    
    var profileImageView: UIImageView {
        if _profileImageView == nil {
            _profileImageView = UIImageView()
        }
        return _profileImageView
    }
    
    var nameLabel: UILabel {
        if _nameLabel == nil {
            _nameLabel = UILabel()
            _nameLabel.font = TNameFontBold
            _nameLabel.textColor = UIColor.whiteColor()
        }
        return _nameLabel
    }
    var usernameLabel: UILabel {
        if _usernameLabel == nil {
            _usernameLabel = UILabel()
            _usernameLabel.font = TUsernameFont
            _usernameLabel.textColor = UIColor.whiteColor()

        }
        return _usernameLabel
    }
    
    var twitterNumer: UIButton {
        if _twitterNumer == nil {
            _twitterNumer = UIButton()
            _twitterNumer.titleLabel?.lineBreakMode = .ByWordWrapping
            _twitterNumer.titleLabel?.textAlignment = .Left
            _twitterNumer.titleLabel?.font = TprofileButtonFont
            _twitterNumer.setTitleColor(TprofileButtonFontColor, forState: .Normal)
        }
        return _twitterNumer
    }
    var followingNumer: UIButton {
        if _followingNumer == nil {
            _followingNumer = UIButton()
            _followingNumer.titleLabel?.lineBreakMode = .ByWordWrapping
            _followingNumer.titleLabel?.textAlignment = .Left
            _followingNumer.titleLabel?.font = TprofileButtonFont
            _followingNumer.setTitleColor(TprofileButtonFontColor, forState: .Normal)
        }
        return _followingNumer
    }

    var followerNumber: UIButton {
        if _followerNumber == nil {
            _followerNumber = UIButton()
            _followerNumber.titleLabel?.lineBreakMode = .ByWordWrapping
            _followerNumber.titleLabel?.textAlignment = .Left
            _followerNumber.titleLabel?.font = TprofileButtonFont
            _followerNumber.setTitleColor(TprofileButtonFontColor, forState: .Normal)
        }
        return _followerNumber
    }

    var tableView: UITableView {
        if _tableView == nil {
            _tableView = UITableView()
            _tableView.delegate = self
            _tableView.dataSource = self
            _tableView.estimatedRowHeight = 200
            _tableView.rowHeight = UITableViewAutomaticDimension
        }
        
        return _tableView
    }

}
