//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MultilineWithIntrinsicButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let titleLabel = self.titleLabel else { return }
        self.titleLabel?.preferredMaxLayoutWidth = titleLabel.frame.width
        super.layoutSubviews()
    }

    override var intrinsicContentSize: CGSize {
        guard let size = self.titleLabel?.intrinsicContentSize else {
            return super.intrinsicContentSize
        }

        let horizontalInsets = contentEdgeInsets.left + contentEdgeInsets.right + titleEdgeInsets.left + titleEdgeInsets.right
        let verticalInsets = contentEdgeInsets.top + contentEdgeInsets.bottom + titleEdgeInsets.top + titleEdgeInsets.bottom
        return CGSize(width: size.width + horizontalInsets,
                      height: size.height + verticalInsets)
    }
}

class MyViewController : UIViewController {
    let button = MultilineWithIntrinsicButton(type: .custom)

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentCompressionResistancePriority(.required, for: .vertical)
//        button.setTitle("However", for: .normal)
        let attributedString = NSAttributedString(string: "However asd asd asd asd asd asd asd asd asdasd ")
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.backgroundColor = .green
        button.contentEdgeInsets = .init(top: 30, left: 30, bottom: 30, right: 30)
        button.titleEdgeInsets = .init(top: 30, left: 30, bottom: 30, right: 30)
        button.backgroundColor = .red
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor)
            ])
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping

        self.view = view
    }
}
// Present the view controller in the Live View window
let viewController = MyViewController()
PlaygroundPage.current.liveView = viewController
viewController.button.frame
