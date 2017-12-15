//
//  ViewController.swift
//  TableViewWithSearchViewContentOffset
//
//  Created by Alexei on 8/30/17.
//  Copyright © 2017 Nezhyborets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let searchView = UISearchBar()
        searchView.sizeToFit()
        self.tableView.tableHeaderView = searchView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

