//
//  NavigationViewController.swift
//  Twitter
//
//  Created by Ping Zhang on 11/3/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import UIKit

class TwitterNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = TwitterNavBackgroundColor
        self.navigationBar.tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
