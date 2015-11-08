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
        if let user = User.currentUser() {
            print(user.credential.oauth_token)
            print(user.credential.oauth_token_secret)
            let twitterHomePage = TwitterNavigationViewController(rootViewController: TwitterViewController())
            //presentViewController(twitterHomePage, animated: true, completion: nil)
            
            if let currentUser = User.currentUser() {
                let parameters =  Dictionary<String, AnyObject>()
                currentUser.get(TwitterHost + "/statuses/home_timeline.json", parameters: parameters,
                    success: {
                        data, response in
                            print("HI")
                    }, failure: {(error: NSError!) -> Void in
                        TwitterHelper.sendAlert("Failure", message: error.localizedDescription)
                        
                })
            }
            
        }
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
            let twitterHomePage = TwitterNavigationViewController(rootViewController: TwitterViewController())
            self.presentViewController(twitterHomePage, animated: true, completion: nil)
            
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

//
//let parameters =  Dictionary<String, AnyObject>()
//twitterClient.client.get("https://api.twitter.com/1.1/statuses/mentions_timeline.json", parameters: parameters,
//    success: {
//        data, response in
//        let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
//        print(jsonDict)
//    }, failure: {(error:NSError!) -> Void in
//        print(error)
//})
//
//
//let parameters =  Dictionary<String, AnyObject>()
//twitterClient.client.get(TwitterHost + "/statuses/home_timeline.json", parameters: parameters,
//    success: {
//        data, response in
//        let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
//        print(jsonDict)
//    }, failure: {(error:NSError!) -> Void in
//        print(error)
//})