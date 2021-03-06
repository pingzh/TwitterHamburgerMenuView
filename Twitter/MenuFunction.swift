//
//  MenuFuntion.swift
//  Twitter
//
//  Created by Ping Zhang on 11/14/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import Foundation
import UIKit

class MenuFunction {
    var name: String!
    var icon: String!
    var status: String!
    
    var destinationViewController: UIViewController!
    
    init(name: String, icon: String, status: String, destinationViewController: UIViewController) {
        self.name = name
        self.icon = icon
        self.status = status
        self.destinationViewController = destinationViewController
    }
}