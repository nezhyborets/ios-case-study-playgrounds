//
//  PushedViewController.swift
//  HidesBottomBarWhenPushed
//
//  Created by Alexei on 4/27/17.
//  Copyright © 2017 Nezhyborets. All rights reserved.
//

import UIKit

class PushedViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            printSubviewsDeeply(view: self.view.window!, deepness: 0)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("----------------VIEW DID APPEAR---------------")
        printSubviewsDeeply(view: self.view.window!, deepness: 0)
    }


}
