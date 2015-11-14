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
    
    private var _twitterNumer: UILabel!
    private var _twitterLabel: UILabel!
    
    private var _followingNumer: UILabel!
    private var _followingLabel: UILabel!
    
    private var _followerNumber: UILabel!
    private var _followerLabel: UILabel!
    
    private var _tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addLayout()
        // Do any additional setup after loading the view.
    }
    
    func addSubviews() {
        view.addSubview(profileBannerImageView)
        
        profileBannerImageView.addSubview(profileImageView)
        profileBannerImageView.addSubview(nameLabel)
        profileBannerImageView.addSubview(usernameLabel)
        
        view.addSubview(twitterNumer)
        view.addSubview(twitterLabel)
        
        view.addSubview(followingNumer)
        view.addSubview(followingLabel)
        
        view.addSubview(followerNumber)
        view.addSubview(followerLabel)
        
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
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ProfiePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension ProfiePageViewController {
//    var profileBannerView: UIView {
//        if _profileBannerView == nil {
//            _profileBannerView = UIView()
//            _profileBannerView.backgroundColor = UIColor(patternImage: UIImage(named: "blur_bg.jpg")!)
//        }
//        return _profileBannerView
//    }
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
    
    var twitterNumer: UILabel {
        if _twitterNumer == nil {
            _twitterNumer = UILabel()
        }
        return _twitterNumer
    }
    var twitterLabel: UILabel {
        if _twitterLabel == nil {
            _twitterLabel = UILabel()
        }
        return _twitterLabel
    }
    var followingNumer: UILabel {
        if _followerNumber == nil {
            _followerNumber = UILabel()
        }
        return _followerNumber
    }
    var followingLabel: UILabel {
        if _followingLabel == nil {
            _followingLabel = UILabel()
        }
        return _followingLabel
    }
    var followerNumber: UILabel {
        if _followerNumber == nil {
            _followerNumber = UILabel()
        }
        return _followerNumber
    }
    var followerLabel: UILabel {
        if _followerLabel == nil {
            _followerLabel = UILabel()
        }
        return _followerLabel
    }
    var tableView: UITableView {
        if _tableView == nil {
            _tableView = UITableView()
//            _tableView.delegate = self
//            _tableView.dataSource = self
            _tableView.estimatedRowHeight = 200
            _tableView.rowHeight = UITableViewAutomaticDimension
        }
        
        return _tableView
    }

}
