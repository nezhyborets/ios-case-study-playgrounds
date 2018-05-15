//
//  ViewController.swift
//  UISwipeActionsConfiguration
//
//  Created by Alexei on 4/2/18.
//  Copyright © 2018 Nezhyborets. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "Swipe"
        return cell!
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "bla") { (action, view, success) in
            success(true)
        }

        return UISwipeActionsConfiguration(actions: [action])
    }
}

