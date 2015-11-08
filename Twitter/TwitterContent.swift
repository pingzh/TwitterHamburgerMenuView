//
//  TwitterContent.swift
//  Twitter
//
//  Created by Ping Zhang on 11/8/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import Foundation

class TwitterContent {
    var name: String!
    var username: String!
    var twitterTime: String!
    var twitterContent: String!
    var profileImageUrl: String!
    
    
    init(name: String, username: String, twitterTime: String, twitterContent: String, profileImageUrl: String) {
        self.name = name
        self.username = username
        self.twitterTime = twitterTime
        self.twitterContent = twitterContent
        self.profileImageUrl = profileImageUrl
    }
}