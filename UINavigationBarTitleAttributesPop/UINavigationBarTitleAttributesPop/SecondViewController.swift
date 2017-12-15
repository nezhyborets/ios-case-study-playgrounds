//
//  SecondViewController.swift
//  UINavigationBarTitleAttributesPop
//
//  Created by Nezhyborets Oleksii on 12/15/17.
//  Copyright © 2017 Nezhyborets Oleksii. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ViewController222"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
