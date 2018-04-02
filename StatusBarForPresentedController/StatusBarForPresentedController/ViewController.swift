//
//  ViewController.swift
//  StatusBarForPresentedController
//
//  Created by Nezhyborets Oleksii on 12/29/17.
//  Copyright © 2017 Nezhyborets Oleksii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let controller = SecondViewController()
            controller.modalPresentationStyle = .custom
            controller.modalPresentationCapturesStatusBarAppearance = true
            self.present(controller, animated: true, completion: nil)
        }
    }
}

