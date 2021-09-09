//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let controllerView = UIView()
        controllerView.backgroundColor = .white
        self.view = controllerView

        let view = UIView(frame: .init(x: 100, y: 100, width: 32, height: 32))
               view.layer.borderWidth = 6
               view.layer.borderColor = UIColor.white.cgColor
               view.backgroundColor = UIColor.clear
               view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.48).cgColor
               view.layer.shadowOpacity = 1
               view.layer.shadowRadius = 8
               view.layer.shadowOffset = CGSize(width: 0, height: 0)
        controllerView.addSubview(view)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
