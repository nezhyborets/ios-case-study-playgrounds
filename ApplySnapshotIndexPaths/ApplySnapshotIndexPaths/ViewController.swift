//
//  ViewController.swift
//  ApplySnapshotIndexPaths
//
//  Created by Nezhyborets Oleksii on 2/21/20.
//  Copyright © 2020 nezhyborets. All rights reserved.
//

import UIKit

class HashableType: Hashable {
    let string: String

    init(string: String) {
        self.string = string
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(string)
    }

    static func == (lhs: HashableType, rhs: HashableType) -> Bool {
        return lhs.string == rhs.string
    }
}

class ViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<String, Item>!

    typealias Item = HashableType

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let dataSource = UICollectionViewDiffableDataSource<String, Item>(collectionView: collectionView!) { (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            let text = identifier.string
            let label = (cell.viewWithTag(1) as! UILabel)
            if label.text != text {
                print("DIFF \(Unmanaged.passUnretained(cell).toOpaque()), identifier: \(identifier), indexPath: \(indexPath)")
                label.text = text
            } else {
                print("same \(Unmanaged.passUnretained(cell).toOpaque()), identifier: \(identifier), indexPath: \(indexPath)")
            }

            cell.backgroundColor = .red

            return cell
        }

        self.dataSource = dataSource
        collectionView.dataSource = dataSource
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("Will apply initial snapshot, collection view: \(collectionView!)")
        var snapshot = NSDiffableDataSourceSnapshot<String, Item>()
        snapshot.appendSections(["0"])
        snapshot.appendItems(
            [item("a"), item("c"), item("e")]
        )
        dataSource.apply(snapshot)
        print("Did apply initial snapshot")
    }

    @IBAction func buttonAction(_ sender: Any) {
        var snapshot = NSDiffableDataSourceSnapshot<String, Item>()
        snapshot.appendSections(["0"])
        snapshot.appendItems([item("a"), item("b"), item("c"), item("d"), item("e")])
        dataSource.apply(snapshot)
    }

    private func item(_ string: String) -> Item {
        HashableType(string: string)
    }
}

