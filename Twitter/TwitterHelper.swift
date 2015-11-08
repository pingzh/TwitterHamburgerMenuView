//
//  TwitterHelper.swift
//  Twitter
//
//  Created by Ping Zhang on 11/7/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import Foundation
import UIKit

class TwitterHelper {
    static func sendAlert(title: String, message: String) {
        let alertView: UIAlertView = UIAlertView()
        alertView.title = title
        alertView.message = message
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
    }
}