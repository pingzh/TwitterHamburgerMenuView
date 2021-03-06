//
//  TwitterUIColor.swift
//  Twitter
//
//  Created by Ping Zhang on 11/7/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import Foundation
import UIKit

let TwitterNavBackgroundColor = UIColor(red:0.35, green:0.66, blue:0.87, alpha:1)

let TwitterNavTextColor = UIColor.whiteColor()

let TwitterConsumerKey = "I4eeAvYePX9oaqnnWPF4ueSG1"
let TwitterConsumerSecret = "PgBmDZuX6sugTMleTnI9kibFw8LzxFVOREngg2M0MCADaZE2yn"
let TwitterRequestTokenUrl = "https://api.twitter.com/oauth/request_token"
let TwitterAuthorizeUrl = "https://api.twitter.com/oauth/authorize"
let TwitterAccessTokenUrl = "https://api.twitter.com/oauth/access_token"


let TwitterHost = "https://api.twitter.com/1.1"

let navBarHeight = 64
let TCellSpan = 8
let TButtonSpanTop = 30
let TButtonSize = 20
let TButtonSpan = 50

let TNameFontBold = UIFont(name: "Avenir-Heavy", size: 14)
let TUsernameFont = UIFont(name: "Avenir", size: 13)
let TUsernameColor = UIColor.grayColor()
let TTwitterTimeColor = UIColor.grayColor()
let TTwitterTimeFont = UIFont(name: "Avenir", size: 13)
let TTwitterContentFont = UIFont(name: "Avenir", size: 13)

let TreplyImage = UIImage(named: "reply.png")
let TretwitterImage = UIImage(named: "retwitter.png")
let TlikeImage = UIImage(named: "like.png")

let screenWidth = UIScreen.mainScreen().bounds.width

let TWMenuWidth = 2 * screenWidth / 3

let NavHeight = 64
let TProfileImageHeight = 48

let TprofileButtonFontColor = UIColor.grayColor()
let TprofileButtonFont = UIFont(name: "Avenir", size: 13)

struct TMenu {
    static let userInfoHeight = 80
    static let leftOffset = 25
    static let offset = 20
    static let nameHeight = 27
    static let nameFont = UIFont(name: "Avenir-Heavy", size: 25)
    static let usernameHeight = 22
    static let usernameFont = UIFont(name: "Avenir", size: 15)


    static let fontColor = UIColor.blackColor()
    
    static let iconSize = 25
    
    static let functionFont = UIFont(name: "Avenir", size: 17)
    static let functionHeight = 30
    static let functionWidth = 100
}
