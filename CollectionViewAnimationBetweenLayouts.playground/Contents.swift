//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController, UICollectionViewDataSource {
    private let layout1: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 50, height: 50)
        return layout
    }()

    private let layout2: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 200, height: 200)
        return layout
    }()

    private lazy var collectionView =  UICollectionView(frame: .zero, collectionViewLayout: layout1)

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view

        view.addSubview(collectionView)

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .red
        collectionView.frame = view.bounds
        collectionView.dataSource = self

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.collectionView.setCollectionViewLayout(self.layout2, animated: true, completion: nil)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
