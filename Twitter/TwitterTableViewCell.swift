//
//  TwitterTableViewCell.swift
//  Twitter
//
//  Created by Ping Zhang on 11/7/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import UIKit

class TwitterTableViewCell: UITableViewCell {
    private var _profileImageView: UIImageView!
    private var _retwitterByLabel: UILabel!
    private var _nameLabel: UILabel!
    private var _usernameLabel: UILabel!
    private var _twitterContent: UILabel!
    private var _replyButton: UIButton!
    private var _retwitterButton: UIButton!
    private var _likeButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //addSubviews()
        //addLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TwitterTableViewCell {
    var profileImageView: UIImageView {
        if _profileImageView == nil {
            _profileImageView = UIImageView()
        }
        return _profileImageView
    }
    
    
}