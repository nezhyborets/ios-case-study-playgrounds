//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 100)
        label.text = "Hello World!"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        
        view.addSubview(label)
        self.view = view
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.addSubview(visualEffectView)
        visualEffectView.frame = view.bounds

        let backgroundColorView = UIView(frame: view.bounds)
        backgroundColorView.backgroundColor = UIColor.blue
//            .withAlphaComponent(0.8)
        visualEffectView.contentView.addSubview(backgroundColorView)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
