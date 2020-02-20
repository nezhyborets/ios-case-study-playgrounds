//
//  WaterfallLayout.swift
//  Bemini
//
//  Created by Богдан Мигилев on 12/11/18.
//  Copyright © 2018 MacPaw Labs. All rights reserved.
//

import UIKit

protocol WaterfallLayoutDelegate: class {
    // MARK: - Required
    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    
    // MARK: - Optional
    var itemSelectedClosure: ((_ indexPath: IndexPath) -> Void)? { get set }
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, minimumInteritemSpacingFor section: Int) -> CGFloat?
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, minimumLineSpacingFor section: Int) -> CGFloat?
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sectionInsetFor section: Int) -> UIEdgeInsets?
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, headerHeightFor section: Int) -> CGFloat?
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, headerInsetFor section: Int) -> UIEdgeInsets?
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, footerHeightFor section: Int) -> CGFloat?
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, footerInsetFor section: Int) -> UIEdgeInsets?
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, estimatedSizeForItemAt indexPath: IndexPath) -> CGSize?
}

extension WaterfallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, minimumInteritemSpacingFor section: Int) -> CGFloat? { return nil }
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, minimumLineSpacingFor section: Int) -> CGFloat? { return nil }
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sectionInsetFor section: Int) -> UIEdgeInsets? { return nil }
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, headerHeightFor section: Int) -> CGFloat? { return nil }
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, headerInsetFor section: Int) -> UIEdgeInsets? { return nil }
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, footerHeightFor section: Int) -> CGFloat? { return nil }
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, footerInsetFor section: Int) -> UIEdgeInsets? { return nil }
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, estimatedSizeForItemAt indexPath: IndexPath) -> CGSize? { return nil }
}

final class WaterfallLayout: UICollectionViewLayout {
    // MARK: - Inner types
    enum DistributionMethod { case equal, balanced }
    
    enum Layout {
        case flow(column: Int)
        case waterfall(column: Int, distributionMethod :DistributionMethod)
        
        var column: Int {
            switch self {
            case let .flow(column): return column
            case let .waterfall(column, _): return column
            }
        }
    }
    
    struct Const {
        static let minimumLineSpacing: CGFloat = 10.0
        static let minimumInteritemSpacing: CGFloat = 10.0
        static let sectionInset: UIEdgeInsets = .zero
        static let headerHeight: CGFloat = 0.0
        static let headerInset: UIEdgeInsets = .zero
        static let footerHeight: CGFloat = 0.0
        static let footerInset: UIEdgeInsets = .zero
        static let estimatedItemSize: CGSize = CGSize(width: 300.0, height: 300.0)
    }
    
    // MARK: - Properties
    var minimumLineSpacing: CGFloat = Const.minimumLineSpacing {
        didSet { invalidateLayoutIfChanged(oldValue, minimumLineSpacing) }
    }
    
    var minimumInteritemSpacing: CGFloat = Const.minimumInteritemSpacing {
        didSet { invalidateLayoutIfChanged(oldValue, minimumInteritemSpacing) }
    }
    
    var sectionInset: UIEdgeInsets = Const.sectionInset {
        didSet { invalidateLayoutIfChanged(oldValue, sectionInset) }
    }
    
    var headerHeight: CGFloat = Const.headerHeight {
        didSet { invalidateLayoutIfChanged(oldValue, headerHeight) }
    }
    
    var headerInset: UIEdgeInsets = Const.headerInset {
        didSet { invalidateLayoutIfChanged(oldValue, headerInset) }
    }
    
    var footerHeight: CGFloat = Const.footerHeight {
        didSet { invalidateLayoutIfChanged(oldValue, footerHeight) }
    }
    
    var footerInset: UIEdgeInsets = Const.footerInset {
        didSet { invalidateLayoutIfChanged(oldValue, footerInset) }
    }
    
    var estimatedItemSize: CGSize = Const.estimatedItemSize {
        didSet { invalidateLayoutIfChanged(oldValue, estimatedItemSize) }
    }
    
    private let headersAttribute = NSMutableDictionary()
    private let footersAttribute = NSMutableDictionary()
    private var columnHeights = [[CGFloat]]()
    private var allItemAttributes = ContiguousArray<UICollectionViewLayoutAttributes>()
    private var sectionItemAttributes = [ContiguousArray<UICollectionViewLayoutAttributes>]()
    private var unionRects: [CGRect] = []
    private let unionSize = 20
    
    private var shouldRelayout = false

    weak var delegate: WaterfallLayoutDelegate?
    
    // MARK: - Overrided
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        shouldRelayout = true
    }
    
    override func prepare() {
        super.prepare()
        guard shouldRelayout else { return }
        
        cleanUp()
        
        guard let collectionView = collectionView else { return }
        guard let delegate = delegate else { return }
        
        let numberOfSections = collectionView.numberOfSections
        if numberOfSections == 0 { return }
        (0..<numberOfSections).forEach { section in
            let columnCount = delegate.collectionViewLayout(for: section).column
            columnHeights.append(Array(repeating: 0.0, count: columnCount))
        }
        
        var position: CGFloat = 0.0
        (0..<numberOfSections).forEach { section in
            layoutHeader(position: &position, collectionView: collectionView, delegate: delegate, section: section)
            layoutItems(position: position, collectionView: collectionView, delegate: delegate, section: section)
            layoutFooter(position: &position, collectionView: collectionView, delegate: delegate, section: section)
        }
        
        var idx = 0
        let itemCounts = allItemAttributes.count
        while idx < itemCounts {
            let rect1 = allItemAttributes[idx].frame
            idx = min(idx + unionSize, itemCounts) - 1
            let rect2 = allItemAttributes[idx].frame
            unionRects.append(rect1.union(rect2))
            idx += 1
        }
        shouldRelayout = false
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView, collectionView.numberOfSections > 0  else {
            return .zero
        }
        var contentSize = collectionView.bounds.size
        contentSize.height = columnHeights.last?.first ?? 0.0
        return contentSize
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return sectionItemAttributes[indexPath.section][indexPath.item]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var begin = 0, end = unionRects.count
        
        if let i = unionRects.firstIndex(where: { rect.intersects($0) }) {
            begin = i * unionSize
        }
        if let i = unionRects.lastIndex(where: { rect.intersects($0) }) {
            end = min((i + 1) * unionSize, allItemAttributes.count)
        }
        return allItemAttributes[begin..<end]
            .filter { rect.intersects($0.frame) }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return newBounds.width != (collectionView?.bounds ?? .zero).width
    }
    
    override func invalidationContext(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
        
        guard let _ = collectionView else { return context }
        
        let oldContentSize = self.collectionViewContentSize
        let newContentSize = self.collectionViewContentSize
        context.contentSizeAdjustment = CGSize(width: 0, height: newContentSize.height - oldContentSize.height)
        _ = context.invalidateEverything
        return context
    }

    // MARK: - Private methods
    private func cleanUp() {
        headersAttribute.removeAllObjects()
        footersAttribute.removeAllObjects()
        columnHeights.removeAll()
        allItemAttributes.removeAll()
        sectionItemAttributes.removeAll()
        unionRects.removeAll()
    }
    
    private func invalidateLayoutIfChanged<T: Equatable>(_ old: T, _ new: T) {
        guard old != new else { return }
        invalidateLayout()
    }
    
    private func layoutHeader(position: inout CGFloat, collectionView: UICollectionView,  delegate: WaterfallLayoutDelegate, section: Int) {
        let columnCount = delegate.collectionViewLayout(for: section).column
        let headerHeight = self.headerHeight(for: section)
        let headerInset = self.headerInset(for: section)
        
        position += headerInset.top
        
        if headerHeight > 0 {
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: [section, 0])
            attributes.frame = CGRect(
                x: headerInset.left,
                y: position,
                width: collectionView.bounds.width - (headerInset.left + headerInset.right),
                height: headerHeight
            )
            headersAttribute[section] = attributes
            allItemAttributes.append(attributes)
            
            position = attributes.frame.maxY + headerInset.bottom
        }
        
        position += sectionInset(for: section).top
        columnHeights[section] = Array(repeating: position, count: columnCount)
    }
    
    private func pickColumn(itemIndex: Int,
                            delegate: WaterfallLayoutDelegate,
                            section: Int) -> Int {
        
        let layout = delegate.collectionViewLayout(for: section)
        switch layout {
        case .flow:
            let columnCount = delegate.collectionViewLayout(for: section).column
            return itemIndex % columnCount
        case .waterfall(_, let distributionMethod):
            if distributionMethod == .balanced {
                var minIndex: Int = 0
                var minValue = CGFloat.greatestFiniteMagnitude
                for (index, element) in columnHeights[section].enumerated() {
                    guard element < minValue else { continue }
                    minIndex = index
                    minValue = element
                }
                return minIndex
            } else {
                let columnCount = delegate.collectionViewLayout(for: section).column
                return itemIndex % columnCount
            }
        }
    }
    
    private func layoutItems(position: CGFloat, collectionView: UICollectionView, delegate: WaterfallLayoutDelegate, section: Int) {
        let sectionInset = self.sectionInset(for: section)
        let minimumInteritemSpacing = self.minimumInteritemSpacing(for: section)
        let minimumLineSpacing = self.minimumInteritemSpacing(for: section)
        
        let columnCount = delegate.collectionViewLayout(for: section).column
        let itemCount = collectionView.numberOfItems(inSection: section)
        let width = collectionView.bounds.width - (sectionInset.left + sectionInset.right)
        let itemWidth = floor((width - CGFloat(columnCount - 1) * minimumLineSpacing) / CGFloat(columnCount))
        let paddingLeft = itemWidth + minimumLineSpacing
        let layout = delegate.collectionViewLayout(for: section)
        
        let itemAttributes = ContiguousArray<UICollectionViewLayoutAttributes>((0..<itemCount)
            .map ({ index -> (UICollectionViewLayoutAttributes) in
                let indexPath: IndexPath = [section, index]
                let columnIndex = self.pickColumn(itemIndex: index, delegate: delegate, section: section)
                let itemSize = delegate.collectionView(collectionView, layout: self, sizeForItemAt: indexPath)
                let itemHeight = itemSize.height
                
                let offsetY: CGFloat
                let columnHeight = self.columnHeights[section][columnIndex]
                switch layout {
                case .flow:
                    offsetY = indexPath.row < columnCount ? position : columnHeight
                case .waterfall:
                    offsetY = columnHeight
                }
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(
                    x: sectionInset.left + paddingLeft * CGFloat(columnIndex),
                    y: offsetY,
                    width: itemWidth,
                    height: itemHeight
                )
                self.columnHeights[section][columnIndex] = attributes.frame.maxY + minimumInteritemSpacing
                
                if case .flow = layout, attributes.indexPath.row % columnCount == columnCount - 1 {
                    let maxHeight = self.columnHeights[section].lazy.enumerated().sorted { $0.element > $1.element }.first?.element ?? 0.0
                    self.columnHeights[section] = Array(repeating: maxHeight, count: columnCount)
                }
                return attributes
        }))
        allItemAttributes.append(contentsOf: itemAttributes)
        sectionItemAttributes.append(itemAttributes)
    }
    
    private func layoutFooter(position: inout CGFloat, collectionView: UICollectionView, delegate: WaterfallLayoutDelegate, section: Int) {
        let sectionInset = self.sectionInset(for: section)
        let columnHeightsAtCurrentSection = columnHeights[section]
        let minimumInteritemSpacing = self.minimumInteritemSpacing(for: section)
        let columnCount = delegate.collectionViewLayout(for: section).column
        let longestColumnIndex = columnHeightsAtCurrentSection.enumerated().sorted { $0.element > $1.element }.first?.offset ?? 0
        
        if !columnHeightsAtCurrentSection.isEmpty {
            position = columnHeightsAtCurrentSection[longestColumnIndex] - minimumInteritemSpacing + sectionInset.bottom
        } else {
            position = 0.0
        }
        let footerHeight = self.footerHeight(for: section)
        let footerInset = self.footerInset(for: section)
        position += footerInset.top
        
        if footerHeight > 0.0 {
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: [section, 0])
            attributes.frame = CGRect(x: footerInset.left, y: position, width: collectionView.bounds.width - (footerInset.left + footerInset.right), height: footerHeight)
            footersAttribute[section] = attributes
            allItemAttributes.append(attributes)
            position = attributes.frame.maxY + footerInset.bottom
        }
        columnHeights[section] = Array(repeating: position, count: columnCount)
    }
    
    private func minimumInteritemSpacing(for section: Int) -> CGFloat {
        return collectionView.flatMap { delegate?.collectionView($0, layout: self, minimumInteritemSpacingFor: section) } ?? minimumInteritemSpacing
    }
    
    private func minimumLineSpacing(for section: Int) -> CGFloat {
        return collectionView.flatMap { delegate?.collectionView($0, layout: self, minimumLineSpacingFor: section) } ?? minimumLineSpacing
    }
    
    private func sectionInset(for section: Int) -> UIEdgeInsets {
        return collectionView.flatMap { delegate?.collectionView($0, layout: self, sectionInsetFor: section) } ?? sectionInset
    }
    
    private func headerHeight(for section: Int) -> CGFloat {
        return collectionView.flatMap { delegate?.collectionView($0, layout: self, headerHeightFor: section) } ?? headerHeight
    }
    
    private func headerInset(for section: Int) -> UIEdgeInsets {
        return collectionView.flatMap { delegate?.collectionView($0, layout: self, headerInsetFor: section) } ?? headerInset
    }
    
    private func footerHeight(for section: Int) -> CGFloat {
        return collectionView.flatMap { delegate?.collectionView($0, layout: self, footerHeightFor: section) } ?? footerHeight
    }
    
    private func footerInset(for section: Int) -> UIEdgeInsets {
        return collectionView.flatMap { delegate?.collectionView($0, layout: self, footerInsetFor: section) } ?? footerInset
    }
    
    private func estimatedSizeForItemAt(_ indexPath: IndexPath) -> CGSize {
        return collectionView.flatMap { delegate?.collectionView($0, layout: self, estimatedSizeForItemAt: indexPath) } ?? estimatedItemSize
    }
}
