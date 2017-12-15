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

        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.yellow]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

