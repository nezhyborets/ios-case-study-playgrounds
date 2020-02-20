//
//  ViewController.swift
//  NonFrontmostCollectionViewCellForItem
//
//  Created by Nezhyborets Oleksii on 2/19/20.
//  Copyright © 2020 nezhyborets. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WaterfallLayoutDelegate, UICollectionViewDataSource {
    var itemSelectedClosure: ((IndexPath) -> Void)?

    @IBOutlet weak var collectionVie: UICollectionView!

    private var stop = false

    override func viewDidLoad() {
        super.viewDidLoad()

        (collectionVie.collectionViewLayout as! WaterfallLayout).delegate = self
        reload()
    }

    @objc func willDismiss() {
        stop = true
    }

    private func reload() {
        guard !stop else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard !self.stop else { return }
            self.collectionVie.reloadData()
            self.reload()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(red: .random(in: 0..<255) / 255,
                                       green: .random(in: 0..<255) / 255,
                                       blue: .random(in: 0..<255) / 255,
                                       alpha: 1)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: 100)
    }

    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout {
        return .flow(column: 2)
    }
}

