//: Playground - noun: a place where people can play

import Cocoa
import PlaygroundSupport

let rootView = NSView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
let collectionView = NSCollectionView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
let layout = NSCollectionViewFlowLayout()
layout.headerReferenceSize = CGSize(width: 100, height: 100)
collectionView.collectionViewLayout = NSCollectionViewFlowLayout()
collectionView.backgroundColors = [.blue]
collectionView.register(NSView.self, forSupplementaryViewOfKind: NSCollectionElementKindSectionHeader, withIdentifier: "opana")

class CollectionViewDataSource : NSObject, NSCollectionViewDataSource {
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        print("dich2")
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        print("dich1")
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        print("dich")
        let view = NSBox()
        view.fillColor = .red
        return view
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        print("dich3")
        return NSCollectionViewItem(nibName: nil, bundle: nil)!
    }
}

class CollectionViewDelegate : NSObject, NSCollectionViewDelegateFlowLayout {
    
}

let dataSource = CollectionViewDataSource()
collectionView.dataSource = dataSource

let delegate = CollectionViewDelegate()
collectionView.delegate = delegate

rootView.addSubview(collectionView)
PlaygroundPage.current.liveView = rootView
PlaygroundPage.current.needsIndefiniteExecution = true
collectionView.reloadData()
