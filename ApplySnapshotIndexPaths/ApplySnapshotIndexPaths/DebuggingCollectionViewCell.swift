//
//  DebuggingCollectionViewCell.swift
//  ApplySnapshotIndexPaths
//
//  Created by Nezhyborets Oleksii on 2/21/20.
//  Copyright © 2020 nezhyborets. All rights reserved.
//

import UIKit

class DebuggingCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()

        print("cell awakeFromNib \(self)")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        print("cell prepareForReuse \(self)")
    }
}
