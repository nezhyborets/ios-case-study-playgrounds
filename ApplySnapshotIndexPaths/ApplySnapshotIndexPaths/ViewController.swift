//
//  ViewController.swift
//  ApplySnapshotIndexPaths
//
//  Created by Nezhyborets Oleksii on 2/21/20.
//  Copyright © 2020 nezhyborets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<String, String>!

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let dataSource = UICollectionViewDiffableDataSource<String, String>(collectionView: collectionView!) { (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            let text = identifier
            let label = (cell.viewWithTag(1) as! UILabel)
            if label.text != text {
                print("DIFF \(Unmanaged.passUnretained(cell).toOpaque()), identifier: \(identifier), indexPath: \(indexPath)")
                label.text = text
            } else {
                print("same \(Unmanaged.passUnretained(cell).toOpaque()), identifier: \(identifier), indexPath: \(indexPath)")
            }

            return cell
        }

        self.dataSource = dataSource
        collectionView.dataSource = dataSource
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("Will apply initial snapshot, collection view: \(collectionView!)")
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(["0"])
        snapshot.appendItems(["a", "c", "e"])
        dataSource.apply(snapshot)
        print("Did apply initial snapshot")
    }

    @IBAction func buttonAction(_ sender: Any) {
        var snapshot = dataSource.snapshot()
        snapshot.insertItems(["b"], afterItem: "a")
        snapshot.insertItems(["d"], afterItem: "c")
        dataSource.apply(snapshot)
    }
}

