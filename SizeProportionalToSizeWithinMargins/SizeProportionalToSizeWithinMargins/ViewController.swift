//
//  ViewController.swift
//  SizeProportionalToSizeWithinMargins
//
//  Created by Nezhyborets Oleksii on 3/28/18.
//  Copyright © 2018 Nezhyborets Oleksii. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let v1 = baseLabel()
        v1.backgroundColor = .yellow
        v1.text = "superview"
        NSLayoutConstraint.activate([
            v1.topAnchor.constraint(equalTo: view.topAnchor),
            v1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            v1.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])

        let v2 = baseLabel()
        v2.backgroundColor = .red
        v2.text = "safeAreaLayoutGuide"
        NSLayoutConstraint.activate([
            v2.topAnchor.constraint(equalTo: view.topAnchor),
            v2.leadingAnchor.constraint(equalTo: v1.trailingAnchor),
            v2.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            v2.widthAnchor.constraint(equalTo: v1.widthAnchor)
            ])

        let v3 = baseLabel()
        v3.backgroundColor = .blue
        v3.text = "layoutMarginsGuide"
        NSLayoutConstraint.activate([
            v3.topAnchor.constraint(equalTo: view.topAnchor),
            v3.leadingAnchor.constraint(equalTo: v2.trailingAnchor),
            v3.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            v3.widthAnchor.constraint(equalTo: v2.widthAnchor)
            ])

        let v4 = baseLabel()
        v4.backgroundColor = .yellow
        v4.text = "snp.superview"
        v4.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.leading.equalTo(v3.snp.trailing)
            maker.height.equalToSuperview()
            maker.width.equalTo(v3)
        }

        let v5 = baseLabel()
        v5.backgroundColor = .red
        v5.text = "snp.safeAreaLayoutGuide"
        v5.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.leading.equalTo(v4.snp.trailing)
            maker.height.equalTo(self.view.safeAreaLayoutGuide)
            maker.width.equalTo(v4)
        }

        let v6 = baseLabel()
        v6.backgroundColor = .blue
        v6.text = "snp.layoutMarginsGuide"
        v6.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.leading.equalTo(v5.snp.trailing)
            maker.height.equalTo(self.view.layoutMarginsGuide)
            maker.width.equalTo(v5)
        }

        let lastView = v6
        lastView.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview()
        }
    }

    private func baseLabel() -> UILabel {
        let v1 = UILabel()
        v1.translatesAutoresizingMaskIntoConstraints = false
        v1.adjustsFontSizeToFitWidth = true
        v1.minimumScaleFactor = 0.5
        view.addSubview(v1)
        return v1
    }
}

