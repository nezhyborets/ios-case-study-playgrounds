//
//  ViewController.swift
//  UITableViewLargeTitle
//
//  Created by Nezhyborets Oleksii on 1/16/20.
//  Copyright © 2020 nezhyborets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = .green
        let contentView = UIView(frame: .init(x: 0, y: 0, width: view.bounds.size.width, height: 818))
        contentView.backgroundColor = .red
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        view.addSubview(scrollView)

        let gest = UITapGestureRecognizer(target: self, action: #selector(open))
        scrollView.addGestureRecognizer(gest)
    }

    @objc private func open() {
        let vc = UIViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.view.backgroundColor = .blue
        navigationController?.pushViewController(vc, animated: true)
    }
}

