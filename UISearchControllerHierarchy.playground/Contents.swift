//: Playground - noun: a place where people can play

import UIKit

let vc = UIViewController()
vc.view.backgroundColor = .white

vc.navigationItem.title = "This is a view controller"

let searchController = UISearchController(searchResultsController: nil)

//searchController.searchBar.barTintColor = UIColor(red:0.16, green:0.45, blue:0.72, alpha:1)
//searchController.searchBar.searchBarStyle = .Minimal
searchController.searchBar.barTintColor = UIColor.orange
searchController.searchBar.tintColor = UIColor.green
vc.navigationItem.titleView = searchController.searchBar

let w = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 480))

let nc = UINavigationController(rootViewController: vc)

w.rootViewController = nc

nc.view.frame
//nc.view.frame = CGRectMake(0, 0, 320, 480)
nc.navigationBar.barStyle = .black
nc.navigationBar.barTintColor = UIColor(red:0.16, green:0.45, blue:0.72, alpha:1)
nc.navigationBar.tintColor = .white
nc.view.setNeedsDisplay()

w.makeKeyAndVisible()

print(nc.viewControllers)
print(nc.presentedViewController)
print(vc.presentedViewController)
searchController.isActive = true
print("activated")
print(nc.viewControllers)
print(nc.presentedViewController)
print(vc.presentedViewController)
print("nc - \(nc.definesPresentationContext)")
print("vc - \(vc.definesPresentationContext)")