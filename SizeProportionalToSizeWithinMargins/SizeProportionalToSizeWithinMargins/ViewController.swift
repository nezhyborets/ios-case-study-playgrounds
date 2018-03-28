//
//  ViewController.swift
//  SizeProportionalToSizeWithinMargins
//
//  Created by Nezhyborets Oleksii on 3/28/18.
//  Copyright © 2018 Nezhyborets Oleksii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let v1 = baseLabel()
        v1.backgroundColor = .yellow
        v1.text = "superview"
        NSLayoutConstraint.activate([
            v1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            v1.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])

        let v2 = baseLabel()
        v2.backgroundColor = .red
        v2.text = "safeAreaLayoutGuide"
        NSLayoutConstraint.activate([
            v2.leadingAnchor.constraint(equalTo: v1.trailingAnchor),
            v2.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            v2.widthAnchor.constraint(equalTo: v1.widthAnchor)
            ])

        let v3 = baseLabel()
        v3.backgroundColor = .blue
        v3.text = "layoutMarginsGuide"
        NSLayoutConstraint.activate([
            v3.leadingAnchor.constraint(equalTo: v2.trailingAnchor),
            v3.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            v3.widthAnchor.constraint(equalTo: v2.widthAnchor)
            ])
    }

    private func baseLabel() -> UILabel {
        let v1 = UILabel()
        v1.translatesAutoresizingMaskIntoConstraints = false
        v1.adjustsFontSizeToFitWidth = true
        v1.minimumScaleFactor = 0.5
        view.addSubview(v1)
        v1.topAnchor.constraint(equalTo: view.topAnchor)
        return v1
    }
}

