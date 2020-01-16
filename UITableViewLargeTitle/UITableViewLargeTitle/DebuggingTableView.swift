//
//  DebuggingTableView.swift
//  Bemini
//
//  Created by Nezhyborets Oleksii on 1/16/20.
//  Copyright © 2020 MacPaw Labs. All rights reserved.
//

import UIKit

class DebuggingTableView: UITableView {
    override var contentOffset: CGPoint {
        didSet {
            //            debugPrint("[DEBUG] tableView contentOffset \(contentOffset)")
        }
    }

    override var contentInset: UIEdgeInsets {
        didSet {
            debugPrint("[DEBUG] tableView contentInset \(contentInset)")
        }
    }

    override var contentSize: CGSize {
        didSet {
            debugPrint("[DEBUG] tableView contentSize \(contentSize)")
        }
    }

    override func adjustedContentInsetDidChange() {
        super.adjustedContentInsetDidChange()

        debugPrint("[DEBUG] tableView adjustedContentInsetDidChange \(adjustedContentInset)")
    }

    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()

        debugPrint("[DEBUG] tableView layoutMarginsDidChange \(layoutMargins)")
    }

    override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()

        debugPrint("[DEBUG] tableView safeAreaInsetsDidChange \(safeAreaInsets)")
    }

    override var directionalLayoutMargins: NSDirectionalEdgeInsets {
        didSet {
            debugPrint("[DEBUG] tableView didSet directionalLayoutMargins \(directionalLayoutMargins)")
        }
    }

    override var layoutMargins: UIEdgeInsets {
        didSet {
            debugPrint("[DEBUG] tableView didSet layoutMargins \(layoutMargins)")
        }
    }
}
