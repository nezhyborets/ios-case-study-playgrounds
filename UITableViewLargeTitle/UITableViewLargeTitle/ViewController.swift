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

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return buildSettingsCell(tableView, for: indexPath)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2, 3, 4:
            return 3
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        open()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }

    // MARK: - Utils methods
    private func buildSettingsCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "asdasd"
        return cell
    }
}

