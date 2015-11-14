//
//  TwitterClient.swift
//  Twitter
//
//  Created by Ping Zhang on 11/7/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import Foundation
import OAuthSwift

class User {
    
    static var currentTwitterClient: TwitterContent!
    
    static var _currentUser: OAuthSwiftClient!
    static func currentUser() -> OAuthSwiftClient? {
        if _currentUser != nil {
            return _currentUser
        }
        
        if let accessToken = _getUserInfoData("accessToken") {
            if let accessTokenSecret = _getUserInfoData("accessTokenSecret") {
                _currentUser = OAuthSwiftClient(
                    consumerKey: TwitterConsumerKey,
                    consumerSecret: TwitterConsumerSecret,
                    accessToken: accessToken,
                    accessTokenSecret: accessTokenSecret
                )
                
                return _currentUser
            }
        }
        return nil
    }
    
    
    static func setCurrentUser(currentUser: OAuthSwiftClient) {
        let userInfoData = ["accessToken": currentUser.credential.oauth_token, "accessTokenSecret": currentUser.credential.oauth_token_secret]
        _setUserInfoData(userInfoData)
        _currentUser = currentUser
    }
    
    static func clearCurrentUser() {
        _currentUser = nil
        _clearUserInfoData()
    }
    
    static func _setUserInfoData(userInfoData: [String: String]) {
        let userInfo = NSUserDefaults.standardUserDefaults()
        for(key, data) in userInfoData {
            if data != "" {
                userInfo.setObject(data, forKey: key)
            }
        }
    }
    
    static func _clearUserInfoData() {
        for key in NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        }
    }
    
    static func _getUserInfoData(key: String) -> String? {
        let userInfo = NSUserDefaults.standardUserDefaults()
        let value = userInfo.stringForKey(key)
        return value
    }
}