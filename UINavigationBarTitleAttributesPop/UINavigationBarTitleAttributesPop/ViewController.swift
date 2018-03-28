//
//  ViewController.swift
//  UINavigationBarTitleAttributesPop
//
//  Created by Nezhyborets Oleksii on 12/15/17.
//  Copyright © 2017 Nezhyborets Oleksii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        title = "ViewController1"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let navBar = navigationController!.navigationBar
        let closure = {
            navBar.titleTextAttributes = [.foregroundColor: UIColor.yellow]
            navBar.largeTitleTextAttributes = [.foregroundColor: UIColor.yellow]
        }

        if let transitionCoordinator = self.transitionCoordinator {
            transitionCoordinator.animateAlongsideTransition(in: navBar, animation: { (_) in
                closure()
            }, completion: nil)
        } else {
            closure()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

