//
//  PrintDeeply.swift
//  HidesBottomBarWhenPushed
//
//  Created by Alexei on 4/27/17.
//  Copyright © 2017 Nezhyborets. All rights reserved.
//

import UIKit

func printSubviewsDeeply(view: UIView, deepness: Int) {
    print("printing deepness \(deepness)")
    view.subviews.forEach { (subview) in
        print(subview)

        if subview.isKind(of: UIImageView.self) {
            print("IS IMAGEVIEW")
        }

        if subview.frame.origin.x < 0 {
            print("X IS NEGATIVE")
        }

        if let presentationLayer = subview.layer.presentation(), presentationLayer.frame.origin.x < 0 {
            print("Presentation Layer X IS NEGATIVE")
        }

        if subview is UITabBar {
            printSuperviewsDeeply(view: subview)
        }
    }

    view.subviews.forEach { (subview) in
        printSubviewsDeeply(view: subview, deepness: deepness + 1)
    }
}

func printSuperviewsDeeply(view: UIView) {
    if let superview = view.superview {
        print("SUPERVIEW is \(superview)")
        printSuperviewsDeeply(view: superview)
    } else {
        print("NO superview")
    }
}
