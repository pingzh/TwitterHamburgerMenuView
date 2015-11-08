//
//  NewTwitterViewController.swift
//  Twitter
//
//  Created by Ping Zhang on 11/8/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import UIKit
import SnapKit

class NewTwitterViewController: UIViewController {

    private var _profileImageView: UIImageView!
    private var _nameLabel: UILabel!
    private var _usernameLabel: UILabel!
    private var _twitterContent: UITextView!
    private var _cancelButton: UIBarButtonItem!
    private var _twitterButton: UIBarButtonItem!
    
    var profileImageUrl: String!
    var name: String!
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addLayout()
        initData()
    }
    
    override func viewDidAppear(animated: Bool) {
        twitterContent.delegate = self
        twitterContent.becomeFirstResponder()
    }
    
    func addSubviews() {
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(twitterContent)
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = twitterButton
    }
    
    func addLayout() {
        profileImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(navBarHeight + TCellSpan)
            make.left.equalTo(view).offset(TCellSpan)
            make.height.equalTo(48)
            make.width.equalTo(48)
            make.bottom.lessThanOrEqualTo(view).offset(-TCellSpan)
        }
        
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(navBarHeight + TCellSpan)
            make.left.equalTo(profileImageView.snp_right).offset(TCellSpan)
        }
        
        usernameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp_bottom).offset(0)
            make.left.equalTo(profileImageView.snp_right).offset(TCellSpan)
        }
        
        twitterContent.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(profileImageView.snp_bottom).offset(0)
            make.left.equalTo(view).offset(TCellSpan)
            make.right.equalTo(view).offset(-TCellSpan)
            make.height.equalTo(200)
        }


    }
    
    func initData() {
        profileImageView.af_setImageWithURL(NSURL(string: profileImageUrl)!)
        nameLabel.text = name
        usernameLabel.text = username
    }
    
    func cancelNewTwitter() {
        twitterContent.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func twitter() {
        twitterContent.resignFirstResponder()
        if let statusMessage = twitterContent.text {
            if let client = User.currentUser() {
                let parameters = ["status": statusMessage]
                client.post(TwitterHost + "/statuses/update.json", parameters: parameters, success: {
                    (data, response) in
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                    }, failure: {(error:NSError!) -> Void in
                        TwitterHelper.sendAlert("Failure", message: "Fail to send the message")
                })
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        twitterContent.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension NewTwitterViewController: UITextViewDelegate {
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
        }
        return _nameLabel
    }
    
    var usernameLabel: UILabel {
        if _usernameLabel == nil {
            _usernameLabel = UILabel()
            _usernameLabel.font = TUsernameFont
            _usernameLabel.textColor = TUsernameColor
        }
        return _usernameLabel
    }
    
    var twitterContent: UITextView {
        if _twitterContent == nil {
            _twitterContent = UITextView()
            
            _twitterContent.delegate = self
            //_twitterContent.layer.borderWidth = 1
            //_twitterContent.layer.borderColor = UIColor.grayColor().CGColor
            _twitterContent.textAlignment = .Left
            _twitterContent.font = TTwitterContentFont
        }
        return _twitterContent
    }
    
    var cancelButton: UIBarButtonItem {
        if _cancelButton == nil {
            _cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelNewTwitter")
        }
        return _cancelButton
    }
    
    var twitterButton: UIBarButtonItem {
        if _twitterButton == nil {
            _twitterButton = UIBarButtonItem(title: "Twitter", style: .Plain, target: self, action: "twitter")
        }
        return _twitterButton
    }
}
