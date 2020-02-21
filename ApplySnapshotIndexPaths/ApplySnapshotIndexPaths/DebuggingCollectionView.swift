//
//  DebuggingCollectionView.swift
//  ApplySnapshotIndexPaths
//
//  Created by Nezhyborets Oleksii on 2/21/20.
//  Copyright © 2020 nezhyborets. All rights reserved.
//

import UIKit

class DebuggingCollectionView: UICollectionView {
    override func insertItems(at indexPaths: [IndexPath]) {
        super.insertItems(at: indexPaths)

        print("insertItems \(indexPaths)")
    }

    override func reloadItems(at indexPaths: [IndexPath]) {
        super.reloadItems(at: indexPaths)

        print("reloadItems \(indexPaths)")
    }

    override func deleteItems(at indexPaths: [IndexPath]) {
        super.deleteItems(at: indexPaths)

        print("deleteItems \(indexPaths)")
    }
}
