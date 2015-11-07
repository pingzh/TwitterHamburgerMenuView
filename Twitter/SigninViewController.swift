//
//  SigninViewController.swift
//  Twitter
//
//  Created by Ping Zhang on 11/7/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {

    private var _signInWithTwitter: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    func addSubviews() {
        //view.addSubview(tableView)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


extension SigninViewController {
    var signInWithTwitter: UIButton {
        if _signInWithTwitter == nil {
            
        }
    }
}