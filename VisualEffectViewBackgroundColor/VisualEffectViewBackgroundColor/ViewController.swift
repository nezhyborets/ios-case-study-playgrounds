//
//  ViewController.swift
//  VisualEffectViewBackgroundColor
//
//  Created by Alexei on 1/10/19.
//  Copyright © 2019 Nezhyborets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 100)
        label.text = "Hello World!"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)

        view.addSubview(label)
        self.view = view
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let visualEffectView = UIVisualEffectView(effect: nil)
        view.addSubview(visualEffectView)
        visualEffectView.frame = view.bounds
//        visualEffectView.alpha = 0

//        let backgroundColorView = UIView(frame: view.bounds)
//        backgroundColorView.backgroundColor = .blue
//        visualEffectView.contentView.addSubview(backgroundColorView)
//        backgroundColorView.alpha = 0
//
        UIView.animate(withDuration: 1) {
            visualEffectView.effect = UIBlurEffect(style: .dark)
//            visualEffectView.alpha = 1
//            backgroundColorView.alpha = 0.6
        }
    }


}

