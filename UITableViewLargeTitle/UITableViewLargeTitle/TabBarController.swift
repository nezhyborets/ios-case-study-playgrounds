//
//  TabBarController.swift
//  UITableViewLargeTitle
//
//  Created by Nezhyborets Oleksii on 1/16/20.
//  Copyright © 2020 nezhyborets. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        additionalSafeAreaInsets = .init(top: 0, left: 0, bottom: 55, right: 0)
    }
}
