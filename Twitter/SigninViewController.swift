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
    
    func addSubviews() {
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
        let oauthswift = OAuth1Swift(
            consumerKey: TwitterConsumerKey,
            consumerSecret: TwitterConsumerSecret,
            requestTokenUrl: TwitterRequestTokenUrl,
            authorizeUrl:    TwitterAuthorizeUrl,
            accessTokenUrl:  TwitterAccessTokenUrl
        )
        
        
        oauthswift.authorizeWithCallbackURL( NSURL(string: "oauth-swift://oauth-callback/twitter")!, success: {
            credential, response in
            print("success")
            //self.showAlertView("Twitter", message: "auth_token:\(credential.oauth_token)\n\noauth_toke_secret:\(credential.oauth_token_secret)")
            let parameters =  Dictionary<String, AnyObject>()
            oauthswift.client.get("https://api.twitter.com/1.1/statuses/mentions_timeline.json", parameters: parameters,
                success: {
                    data, response in
                    let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                    print(jsonDict)
                }, failure: {(error:NSError!) -> Void in
                    print(error)
            })
            }, failure: {(error:NSError!) -> Void in
                print(error.localizedDescription)
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