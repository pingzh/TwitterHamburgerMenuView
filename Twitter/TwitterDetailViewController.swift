//
//  NewTwitterViewController.swift
//  Twitter
//
//  Created by Ping Zhang on 11/8/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import UIKit
import SnapKit

class TwitterDetailViewController: UIViewController {
    
    private var _profileImageView: UIImageView!
    private var _nameLabel: UILabel!
    private var _usernameLabel: UILabel!
    private var _twitterContent: UILabel!
    private var _cancelButton: UIBarButtonItem!
    private var _twitterButton: UIBarButtonItem!
    private var _replyButton: UIButton!
    private var _retwitterButton: UIButton!
    private var _likeButton: UIButton!

    
    var profileImageUrl: String!
    var name: String!
    var username: String!
    
    var selectedTwitter: TwitterContent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addLayout()
        initData()
    }
    
    func addSubviews() {
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(twitterContent)
        view.addSubview(replyButton)
        view.addSubview(retwitterButton)
        view.addSubview(likeButton)
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
            make.top.equalTo(profileImageView.snp_bottom).offset(TCellSpan)
            make.left.equalTo(view).offset(TCellSpan)
            make.right.equalTo(view).offset(-TCellSpan)
        }
        
        
        replyButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(twitterContent.snp_bottom).offset(TCellSpan)
            make.left.equalTo(twitterContent.snp_left).offset(TCellSpan)
            //make.bottom.equalTo(view).offset(-TCellSpan)
            make.width.equalTo(TButtonSize)
            make.height.equalTo(TButtonSize)
        }
        
        retwitterButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(twitterContent.snp_bottom).offset(TCellSpan)
            make.left.equalTo(replyButton.snp_right).offset(TButtonSpan)
            //make.bottom.equalTo(self).offset(-TCellSpan)
            make.width.equalTo(TButtonSize)
            make.height.equalTo(TButtonSize)
        }
        
        likeButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(twitterContent.snp_bottom).offset(TCellSpan)
            make.left.equalTo(retwitterButton.snp_right).offset(TButtonSpan)
            //make.bottom.equalTo(self).offset(-TCellSpan)
            make.width.equalTo(TButtonSize)
            make.height.equalTo(TButtonSize)
        }
        
    }
    
    func initData() {
        profileImageView.af_setImageWithURL(NSURL(string: selectedTwitter.profileImageUrl)!)
        nameLabel.text = selectedTwitter.name
        usernameLabel.text = selectedTwitter.username
        twitterContent.text = selectedTwitter.twitterContent
    }
    
    func cancelNewTwitter() {
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
    
    func replyTwitter() {
        TwitterHelper.sendAlert("Reply", message: "replyTwitter")
    }
    
    func retwitter() {
        TwitterHelper.sendAlert("Retwitter", message: "retwitter")
    }
    
    func likeTwitter() {
        TwitterHelper.sendAlert("Like", message: "likeTwitter")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension TwitterDetailViewController: UITextViewDelegate {
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
    
    var twitterContent: UILabel {
        if _twitterContent == nil {
            _twitterContent = UILabel()
            _twitterContent.font = TTwitterContentFont
            _twitterContent.numberOfLines = 0
            _twitterContent.lineBreakMode = .ByWordWrapping
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
    
    var replyButton: UIButton {
        if _replyButton == nil {
            _replyButton = UIButton()
            _replyButton.setImage(TreplyImage, forState: .Normal)
            _replyButton.addTarget(self, action: "replyTwitter", forControlEvents: UIControlEvents.TouchUpInside)
        }
        return _replyButton
    }
    
    var retwitterButton: UIButton {
        if _retwitterButton == nil {
            _retwitterButton = UIButton()
            _retwitterButton.setImage(TretwitterImage, forState: .Normal)
            _retwitterButton.addTarget(self, action: "retwitter", forControlEvents: UIControlEvents.TouchUpInside)
        }
        return _retwitterButton
    }
    
    var likeButton: UIButton {
        if _likeButton == nil {
            _likeButton = UIButton()
            _likeButton.setImage(TlikeImage, forState: .Normal)
            _likeButton.addTarget(self, action: "likeTwitter", forControlEvents: UIControlEvents.TouchUpInside)
        }
        return _likeButton
    }

}
