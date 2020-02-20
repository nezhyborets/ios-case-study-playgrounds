//
//  DetailViewController.swift
//  NonFrontmostCollectionViewCellForItem
//
//  Created by Nezhyborets Oleksii on 2/19/20.
//  Copyright © 2020 nezhyborets. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBAction func closeButtonAction(_ sender: Any) {
        UIApplication.shared.sendAction(#selector(ViewController.willDismiss), to: self.presentingViewController, from: nil, for: nil)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
