//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

/* 
 In this Playground we can see that we cannot rely on same cell returned for a given indexPath after reloadData in UICollectionView, though it seems to be working for UITableView.
 
 Furthermore, we can see that it actually has some kind of backward order, but it doesn't seem to be useful. This order doesn't seem to depend on flow layout scroll direction.
 
 As a side note, we can see that UICollectionView instance calls reloadData() implicitly when we set it's dataSource (as opposite to that same for instance of UITableView)
 
 Background (reason for research): Image blinking inside cell when reloading cells using reloadData(). There should be no reason to clear image on prepareForReuse (or similar) if a given cell was already display the given image and this image didn't change on reloadData().
 
 Like we could do this, which works fine for UITableView's reloadData():
 
 if cell.itemIdentifier != item.uniqueIdentifier {
    cell.itemIdentifier = item.uniqueIdentifier
    cell.set(image: nil)
 }
 
 item.getImageToDisplay { (image) in
    if #available(iOS 10.0, *) {
        dispatchPrecondition(condition: .onQueue(.main))
    } else {
        // Fallback on earlier versions
    }
 
    cell.set(image: image)
 }
 */

PlaygroundPage.current.needsIndefiniteExecution = true

class TableDataSource : NSObject, UITableViewDataSource {
    static  let reuseIdentifier = "tableReuseIdentifier"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableDataSource.reuseIdentifier, for: indexPath)
        print("Table indexPath.row: \(indexPath.row) tag: \(cell.tag)")
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}

class CollectionDataSource : NSObject, UICollectionViewDataSource {
    static let reuseIdentifier = "collectionReuseIdentifier"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionDataSource.reuseIdentifier, for: indexPath)
        print("Collection indexPath.row: \(indexPath.row) tag: \(cell.tag)")
        cell.tag = indexPath.row
        return cell
    }
}

let w = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
let vc = UIViewController()
w.rootViewController = vc
w.makeKeyAndVisible()

let tableView = UITableView(frame: vc.view.bounds, style: .plain)
tableView.register(UITableViewCell.self, forCellReuseIdentifier: TableDataSource.reuseIdentifier)
vc.view.addSubview(tableView)
let tableViewDataSource = TableDataSource()
print("Table Set DataSource")
tableView.dataSource = tableViewDataSource
print("Table Reload 1")
tableView.reloadData()
print("Table Reload 2")
tableView.reloadData()

let collectionViewLayoutVertical = UICollectionViewFlowLayout()
let collectionViewVertical = UICollectionView(frame: vc.view.bounds, collectionViewLayout: collectionViewLayoutVertical)
collectionViewVertical.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CollectionDataSource.reuseIdentifier)
vc.view.addSubview(collectionViewVertical)
let collectionViewDataSourceVertical = CollectionDataSource()
print("CollectionVertical Set DataSource")
collectionViewVertical.dataSource = collectionViewDataSourceVertical
print("CollectionVertical Reload 1")
collectionViewVertical.reloadData()
print("CollectionVertical Reload 2")
collectionViewVertical.reloadData()

let collectionViewLayoutHorizontal = UICollectionViewFlowLayout()
collectionViewLayoutHorizontal.scrollDirection = .horizontal
let collectionViewHorizontal = UICollectionView(frame: vc.view.bounds, collectionViewLayout: collectionViewLayoutHorizontal)
collectionViewHorizontal.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CollectionDataSource.reuseIdentifier)
vc.view.addSubview(collectionViewHorizontal)
let collectionViewDataSourceHorizontal = CollectionDataSource()
print("CollectionHorizontal Set DataSource")
collectionViewHorizontal.dataSource = collectionViewDataSourceHorizontal
print("CollectionHorizontal Reload 1")
collectionViewHorizontal.reloadData()
print("CollectionHorizontal Reload 2")
collectionViewHorizontal.reloadData()

/*
 Table Set DataSource
 Table Reload 1
 Table indexPath.row: 0 tag: 0
 Table indexPath.row: 1 tag: 0
 Table indexPath.row: 2 tag: 0
 Table indexPath.row: 3 tag: 0
 Table indexPath.row: 4 tag: 0
 Table indexPath.row: 5 tag: 0
 Table indexPath.row: 6 tag: 0
 Table indexPath.row: 7 tag: 0
 Table indexPath.row: 8 tag: 0
 Table indexPath.row: 9 tag: 0
 Table indexPath.row: 10 tag: 0
 Table Reload 2
 Table indexPath.row: 0 tag: 0
 Table indexPath.row: 1 tag: 1
 Table indexPath.row: 2 tag: 2
 Table indexPath.row: 3 tag: 3
 Table indexPath.row: 4 tag: 4
 Table indexPath.row: 5 tag: 5
 Table indexPath.row: 6 tag: 6
 Table indexPath.row: 7 tag: 7
 Table indexPath.row: 8 tag: 8
 Table indexPath.row: 9 tag: 9
 Table indexPath.row: 10 tag: 10
 CollectionVertical Set DataSource
 Collection indexPath.row: 0 tag: 0
 Collection indexPath.row: 1 tag: 0
 Collection indexPath.row: 2 tag: 0
 Collection indexPath.row: 3 tag: 0
 Collection indexPath.row: 4 tag: 0
 Collection indexPath.row: 5 tag: 0
 Collection indexPath.row: 6 tag: 0
 Collection indexPath.row: 7 tag: 0
 Collection indexPath.row: 8 tag: 0
 Collection indexPath.row: 9 tag: 0
 Collection indexPath.row: 10 tag: 0
 Collection indexPath.row: 11 tag: 0
 Collection indexPath.row: 12 tag: 0
 Collection indexPath.row: 13 tag: 0
 Collection indexPath.row: 14 tag: 0
 Collection indexPath.row: 15 tag: 0
 Collection indexPath.row: 16 tag: 0
 Collection indexPath.row: 17 tag: 0
 Collection indexPath.row: 18 tag: 0
 Collection indexPath.row: 19 tag: 0
 CollectionVertical Reload 1
 Collection indexPath.row: 0 tag: 9
 Collection indexPath.row: 1 tag: 8
 Collection indexPath.row: 2 tag: 7
 Collection indexPath.row: 3 tag: 6
 Collection indexPath.row: 4 tag: 5
 Collection indexPath.row: 5 tag: 4
 Collection indexPath.row: 6 tag: 3
 Collection indexPath.row: 7 tag: 2
 Collection indexPath.row: 8 tag: 1
 Collection indexPath.row: 9 tag: 0
 Collection indexPath.row: 10 tag: 19
 Collection indexPath.row: 11 tag: 18
 Collection indexPath.row: 12 tag: 17
 Collection indexPath.row: 13 tag: 16
 Collection indexPath.row: 14 tag: 15
 Collection indexPath.row: 15 tag: 14
 Collection indexPath.row: 16 tag: 13
 Collection indexPath.row: 17 tag: 12
 Collection indexPath.row: 18 tag: 11
 Collection indexPath.row: 19 tag: 10
 CollectionVertical Reload 2
 Collection indexPath.row: 0 tag: 9
 Collection indexPath.row: 1 tag: 8
 Collection indexPath.row: 2 tag: 7
 Collection indexPath.row: 3 tag: 6
 Collection indexPath.row: 4 tag: 5
 Collection indexPath.row: 5 tag: 4
 Collection indexPath.row: 6 tag: 3
 Collection indexPath.row: 7 tag: 2
 Collection indexPath.row: 8 tag: 1
 Collection indexPath.row: 9 tag: 0
 Collection indexPath.row: 10 tag: 19
 Collection indexPath.row: 11 tag: 18
 Collection indexPath.row: 12 tag: 17
 Collection indexPath.row: 13 tag: 16
 Collection indexPath.row: 14 tag: 15
 Collection indexPath.row: 15 tag: 14
 Collection indexPath.row: 16 tag: 13
 Collection indexPath.row: 17 tag: 12
 Collection indexPath.row: 18 tag: 11
 Collection indexPath.row: 19 tag: 10
 CollectionHorizontal Set DataSource
 Collection indexPath.row: 0 tag: 0
 Collection indexPath.row: 1 tag: 0
 Collection indexPath.row: 2 tag: 0
 Collection indexPath.row: 3 tag: 0
 Collection indexPath.row: 4 tag: 0
 Collection indexPath.row: 5 tag: 0
 Collection indexPath.row: 6 tag: 0
 Collection indexPath.row: 7 tag: 0
 Collection indexPath.row: 8 tag: 0
 Collection indexPath.row: 9 tag: 0
 Collection indexPath.row: 10 tag: 0
 Collection indexPath.row: 11 tag: 0
 Collection indexPath.row: 12 tag: 0
 Collection indexPath.row: 13 tag: 0
 Collection indexPath.row: 14 tag: 0
 Collection indexPath.row: 15 tag: 0
 Collection indexPath.row: 16 tag: 0
 Collection indexPath.row: 17 tag: 0
 Collection indexPath.row: 18 tag: 0
 Collection indexPath.row: 19 tag: 0
 CollectionHorizontal Reload 1
 Collection indexPath.row: 0 tag: 9
 Collection indexPath.row: 1 tag: 8
 Collection indexPath.row: 2 tag: 7
 Collection indexPath.row: 3 tag: 6
 Collection indexPath.row: 4 tag: 5
 Collection indexPath.row: 5 tag: 4
 Collection indexPath.row: 6 tag: 3
 Collection indexPath.row: 7 tag: 2
 Collection indexPath.row: 8 tag: 1
 Collection indexPath.row: 9 tag: 0
 Collection indexPath.row: 10 tag: 19
 Collection indexPath.row: 11 tag: 18
 Collection indexPath.row: 12 tag: 17
 Collection indexPath.row: 13 tag: 16
 Collection indexPath.row: 14 tag: 15
 Collection indexPath.row: 15 tag: 14
 Collection indexPath.row: 16 tag: 13
 Collection indexPath.row: 17 tag: 12
 Collection indexPath.row: 18 tag: 11
 Collection indexPath.row: 19 tag: 10
 CollectionHorizontal Reload 2
 Collection indexPath.row: 0 tag: 9
 Collection indexPath.row: 1 tag: 8
 Collection indexPath.row: 2 tag: 7
 Collection indexPath.row: 3 tag: 6
 Collection indexPath.row: 4 tag: 5
 Collection indexPath.row: 5 tag: 4
 Collection indexPath.row: 6 tag: 3
 Collection indexPath.row: 7 tag: 2
 Collection indexPath.row: 8 tag: 1
 Collection indexPath.row: 9 tag: 0
 Collection indexPath.row: 10 tag: 19
 Collection indexPath.row: 11 tag: 18
 Collection indexPath.row: 12 tag: 17
 Collection indexPath.row: 13 tag: 16
 Collection indexPath.row: 14 tag: 15
 Collection indexPath.row: 15 tag: 14
 Collection indexPath.row: 16 tag: 13
 Collection indexPath.row: 17 tag: 12
 Collection indexPath.row: 18 tag: 11
 Collection indexPath.row: 19 tag: 10
 */
