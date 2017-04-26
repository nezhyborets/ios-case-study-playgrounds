//
//  TabBarController.swift
//  HidesBottomBarWhenPushed
//
//  Created by Alexei on 4/27/17.
//  Copyright © 2017 Nezhyborets. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        printSuperviewsDeeply(view: self.tabBar)
    }
}
