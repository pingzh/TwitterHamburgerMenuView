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
    var profileBannerImageUrl: String!
    
    var twitters: Int!
    var followings: Int!
    var followers: Int!
    
    
    
    init(name: String, username: String, twitterTime: String, twitterContent: String, profileImageUrl: String, profileBannerImageUrl: String, twitters: Int, followings: Int, followers: Int) {
        self.name = name
        self.username = username
        self.twitterTime = twitterTime
        self.twitterContent = twitterContent
        self.profileImageUrl = profileImageUrl
        self.profileBannerImageUrl = profileBannerImageUrl
        self.twitters = twitters
        self.followings = followings
        self.followers = followers
    }
    
    
//    init(twitterUserData: NSDictionary) {
//        
//        let profileImageUrl = twitterUserData["profile_image_url"] as! String
//        let profileBannerImageUrl = ""//user["profile_banner_url"] as? String
//        
//        let twitterText = twitter["text"] as! String
//        
//        let twitteredData = twitter["created_at"] as! String
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
//        let date = dateFormatter.dateFromString(twitteredData)
//        
//        name: twitterUserData["name"] as! String,
//        username: ("@" + (twitterUserData["screen_name"] as! String)),
//        twitterTime: "4h",
//        twitterContent: twitterText,
//        profileImageUrl: profileImageUrl,
//        profileBannerImageUrl: profileBannerImageUrl,
//        twitters: user["listed_count"] as! Int,
//        followings: user["following"] as! Int,
//        followers: user["followers_count"] as! Int
//    }
}