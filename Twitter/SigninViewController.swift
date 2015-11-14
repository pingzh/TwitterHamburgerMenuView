//
//  SigninViewController.swift
//  Twitter
//
//  Created by Ping Zhang on 11/7/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import UIKit
import SnapKit
import OAuthSwift


class SigninViewController: UIViewController {
    
    private var _signInWithTwitterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addLayouts()
    }
    
    override func viewWillAppear(animated: Bool) {
        //        if let user = User.currentUser() {
        //            print(user.credential.oauth_token)
        //            print(user.credential.oauth_token_secret)
        //            let twitterHomePage = TwitterNavigationViewController(rootViewController: TwitterViewController())
        //            presentViewController(twitterHomePage, animated: true, completion: nil)
        //        }
    }
    
    
    func addSubviews() {
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(signInWithTwitterButton)
    }
    
    func addLayouts() {
        signInWithTwitterButton.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didPressSignInWithTwitterButton() {
        let twitterClient = OAuth1Swift(
            consumerKey: TwitterConsumerKey,
            consumerSecret: TwitterConsumerSecret,
            requestTokenUrl: TwitterRequestTokenUrl,
            authorizeUrl:    TwitterAuthorizeUrl,
            accessTokenUrl:  TwitterAccessTokenUrl
        )
        
        twitterClient.authorizeWithCallbackURL(NSURL(string: "oauth-swift://oauth-callback/twitter")!, success: {
            credential, response in
            User.setCurrentUser(twitterClient.client)
            
            twitterClient.client.get(TwitterHost + "/account/verify_credentials.json", parameters: [:], success:
                { data, response in
                    if let user = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary {
                        
                        let profileImageUrl = user["profile_image_url"] as! String
                        let profileBannerImageUrl = "" //user["profile_banner_url"] as? String
                        let authedTwitterClient = TwitterContent(
                            name: user["name"] as! String,
                            username: ("@" + (user["screen_name"] as! String)),
                            twitterTime: "4h",
                            twitterContent: "twitterText",
                            profileImageUrl: profileImageUrl,
                            profileBannerImageUrl: profileBannerImageUrl,
                            twitters: user["listed_count"] as! Int,
                            followings: user["following"] as! Int,
                            followers: user["followers_count"] as! Int
                            
                        )
                        User.currentTwitterClient = authedTwitterClient
                        
                        
                        let twitterViewController = TwitterViewController()
                        twitterViewController.myAccountViewController = MyAccountViewController()
                        let twitterHomePage = TwitterNavigationViewController(rootViewController: twitterViewController)
                        self.presentViewController(twitterHomePage, animated: true, completion: nil)
                        
                    }
                }, failure: {(error: NSError!) -> Void in
                    TwitterHelper.sendAlert("Failure", message: error.localizedDescription)
            })
            }, failure: {(error:NSError!) -> Void in
                TwitterHelper.sendAlert("Fail", message: error.localizedDescription)
            }
        )
        
    }
    
}


extension SigninViewController {
    var signInWithTwitterButton: UIButton {
        if _signInWithTwitterButton == nil {
            
            let image = UIImage(named: "signInWithTwitter")!
            let tempButton = UIButton()
            tempButton.setImage(image, forState: .Normal)
            tempButton.addTarget(self, action: "didPressSignInWithTwitterButton", forControlEvents:.TouchUpInside)
            
            _signInWithTwitterButton = tempButton
        }
        return _signInWithTwitterButton
    }
}