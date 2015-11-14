//
//  TwitterTableViewCell.swift
//  Twitter
//
//  Created by Ping Zhang on 11/7/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import UIKit
import AlamofireImage

class TwitterTableViewCell: UITableViewCell {
    private var _profileImageView: UIImageView!
    private var _nameLabel: UILabel!
    private var _usernameLabel: UILabel!
    private var _twitterTime: UILabel!
    private var _twitterContent: UILabel!
    private var _replyButton: UIButton!
    private var _retwitterButton: UIButton!
    private var _likeButton: UIButton!
    
    private var twitter: TwitterContent!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func addSubviews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(twitterTime)
        addSubview(twitterContent)
        addSubview(replyButton)
        addSubview(retwitterButton)
        addSubview(likeButton)
    }
    
    func addLayout() {
        profileImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(TCellSpan)
            make.left.equalTo(self).offset(TCellSpan)
            make.height.equalTo(48)
            make.width.equalTo(48)
            make.bottom.lessThanOrEqualTo(self).offset(-TCellSpan)
        }
        
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(TCellSpan)
            make.left.equalTo(profileImageView.snp_right).offset(TCellSpan)
        }
        
        nameLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        
        usernameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(TCellSpan)
            make.left.equalTo(nameLabel.snp_right).offset(0)
        }
        
        twitterTime.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(TCellSpan)
            make.left.greaterThanOrEqualTo(usernameLabel.snp_right).offset(TCellSpan)
            make.right.lessThanOrEqualTo(self).offset(-TCellSpan)
        }
        
        twitterContent.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp_bottom).offset(0)
            make.left.equalTo(profileImageView.snp_right).offset(TCellSpan)
            make.right.equalTo(self).offset(-TCellSpan)
        }
        
        replyButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(twitterContent.snp_bottom).offset(0)
            make.left.equalTo(twitterContent.snp_left).offset(0)
            make.bottom.equalTo(self).offset(-TCellSpan)
            make.width.equalTo(TButtonSize)
            make.height.equalTo(TButtonSize)
        }
        
        retwitterButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(twitterContent.snp_bottom).offset(0)
            make.left.equalTo(replyButton.snp_right).offset(TButtonSpan)
            make.bottom.equalTo(self).offset(-TCellSpan)
            make.width.equalTo(TButtonSize)
            make.height.equalTo(TButtonSize)
        }
        
        likeButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(twitterContent.snp_bottom).offset(0)
            make.left.equalTo(retwitterButton.snp_right).offset(TButtonSpan)
            make.bottom.equalTo(self).offset(-TCellSpan)
            make.width.equalTo(TButtonSize)
            make.height.equalTo(TButtonSize)
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
    
    
    func setTwitter(twitter: TwitterContent) {
        self.twitter = twitter
        let imageNSUrl = NSURL(string: twitter.profileImageUrl)!
        profileImageView.af_setImageWithURL(imageNSUrl)
        nameLabel.text = twitter.name
        usernameLabel.text = twitter.username
        twitterTime.text = twitter.twitterTime
        twitterContent.text = twitter.twitterContent
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

extension TwitterTableViewCell {
    var profileImageView: UIImageView {
        if _profileImageView == nil {
            _profileImageView = UIImageView()
            _profileImageView.userInteractionEnabled = true
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
    
    var twitterTime: UILabel {
        if _twitterTime == nil {
            _twitterTime = UILabel()
            _twitterTime.font = TTwitterTimeFont
            _twitterTime.textColor = TTwitterTimeColor
        }
        return _twitterTime
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