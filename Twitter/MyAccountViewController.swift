//
//  MenuViewController.swift
//  Twitter
//
//  Created by Ping Zhang on 11/14/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//


import UIKit
import SnapKit

class MyAccountViewController: UIViewController {
    
    private var _userInfoView: UIView!
    private var _line: UIView!
    private var _nameLabel: UILabel!
    private var _usernameLabel: UILabel!
    
    private var _profileImageView: UIImageView!
    
    private var _tableView: UITableView!
    
    var functions: [MenuFunction] = []
    
    var twitterViewController: TwitterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addLayout()
        initData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //initData()
    }
    
    func addSubviews() {
        view.addSubview(userInfoView)
        navigationItem.title = "My Account"
        
        userInfoView.addSubview(profileImageView)
        userInfoView.addSubview(nameLabel)
        userInfoView.addSubview(usernameLabel)
        
        view.addSubview(line)
        view.addSubview(tableView)
    }
    
    
    func addLayout() {
        view.backgroundColor = UIColor.whiteColor()
        

        userInfoView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(NavHeight)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(TMenu.userInfoHeight)
        }
        
        profileImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(userInfoView).offset(TMenu.offset)
            make.left.equalTo(userInfoView).offset(TMenu.offset)
            make.height.equalTo(TProfileImageHeight)
            make.width.equalTo(TProfileImageHeight)
        }
        
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(userInfoView).offset(TMenu.offset)
            make.left.equalTo(profileImageView.snp_right).offset(TMenu.leftOffset)
            make.height.equalTo(TMenu.nameHeight)
        }
        
        usernameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp_bottom).offset(0)
            make.left.equalTo(nameLabel.snp_left).offset(0)
            make.height.equalTo(TMenu.usernameHeight)
        }
        
        line.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(userInfoView.snp_bottom).offset(0)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(0.5)
        }
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(line.snp_bottom).offset(0)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
        }
        
    }
    
    func initData() {
        setUserInfo()
        loadMyAccountItems()
    }
    
    func setUserInfo() {
        
        if let currentUser = User.currentTwitterClient {
            nameLabel.text = currentUser.name
            usernameLabel.text = currentUser.username
            profileImageView.af_setImageWithURL(NSURL(string: currentUser.profileImageUrl)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MyAccountViewController {
    func loadMyAccountItems() {
        
        let views = MenuFunction(name: "Home", icon: "home", status: "")
        let messages = MenuFunction(name: "Messages", icon: "message", status: "5")
        let notifications = MenuFunction(name: "Notifications", icon: "notifications", status: "2")
        let moments = MenuFunction(name: "Moments", icon: "moments", status: "2")
        let logout = MenuFunction(name: "Log Out", icon: "logout", status: "")
        
        functions = [views, messages, notifications, moments, logout]
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSLog("touch")
        twitterViewController.contentViewController = twitterViewController//TwitterViewController() //
    }
}

extension MyAccountViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseId = "MyAccountTableViewCell"
        let cell: MyAccountTableViewCell
        if let reuseCell = tableView.dequeueReusableCellWithIdentifier(reuseId) as? MyAccountTableViewCell {
            cell = reuseCell
        }
        else {
            cell = MyAccountTableViewCell(style: .Subtitle, reuseIdentifier: reuseId)
        }
        
        let function = functions[indexPath.row]
        cell.setMyAccountFunction(function)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        let selectedTwitter = twitters[indexPath.row]
        //        let twitterDetail = TwitterDetailViewController()
        //        twitterDetail.selectedTwitter = selectedTwitter
        //
        //        self.navigationController?.pushViewController(twitterDetail, animated: true)
        NSLog("didSelect")
    }
}


extension MyAccountViewController {
    var userInfoView: UIView {
        if _userInfoView == nil {
            _userInfoView = UIView()
            _userInfoView.backgroundColor = UIColor.clearColor()
            
        }
        return _userInfoView
    }
    
    
    
    var line: UIView {
        if _line == nil {
            _line = UIView()
            _line.backgroundColor = UIColor.blackColor()
        }
        return _line
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
            _nameLabel.font = TMenu.nameFont
            _nameLabel.textColor = TMenu.fontColor
        }
        return _nameLabel
    }
    
    var usernameLabel: UILabel {
        if _usernameLabel == nil {
            _usernameLabel = UILabel()
            _usernameLabel.font = TMenu.usernameFont
            _usernameLabel.textColor = TMenu.fontColor
        }
        return _usernameLabel
    }
    
    
    
    var tableView: UITableView {
        if _tableView == nil {
            _tableView = UITableView()
            _tableView.delegate = self
            _tableView.dataSource = self
            _tableView.estimatedRowHeight = 80
            _tableView.rowHeight = UITableViewAutomaticDimension
            _tableView.backgroundColor = UIColor.clearColor()
            _tableView.separatorColor = UIColor.blackColor()
            _tableView.separatorInset = UIEdgeInsetsZero
            _tableView.scrollEnabled = false
            _tableView.tableFooterView = UIView(frame: CGRectZero)
        }
        return _tableView
    }
    
}