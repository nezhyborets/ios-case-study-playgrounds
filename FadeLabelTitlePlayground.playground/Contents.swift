//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

var str = "Hello, playground"

let contentView = UIView(frame: .init(x: 0, y: 0, width: 200, height: 150))
contentView.backgroundColor = .green

let titleLabel = UILabel(frame: .zero)
titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
titleLabel.textColor = .white
titleLabel.text = "1"

let subtitleLabel = UILabel(frame: .zero)
subtitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
subtitleLabel.textColor = .red
subtitleLabel.text = "2"

let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
stackView.spacing = 1
stackView.distribution = .equalSpacing
stackView.axis = .vertical
contentView.addSubview(stackView)
stackView.frame = .init(x: 0, y: 0, width: 200, height: 100)

let labelOutsideStackView = UILabel(frame: .init(x: 0, y: 0, width: 200, height: 50))
labelOutsideStackView.text = "5555"

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = contentView

print(stackView)

        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade;
        animation.duration = 0.6;
        labels.forEach { $0.layer.add(animation, forKey: "kCATransitionFade") }
        changeLabelsTextClosure()

func animate(with view: UIView, closure: @escaping () -> Void) {
    UIView.transition(with: view, duration: 0.6, options: [.curveEaseInOut, .transitionCrossDissolve], animations: {
        closure()
    }, completion: nil)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//    UIView.transition(with: titleLabel, duration: 0.6, options: [.curveEaseInOut, .transitionCrossDissolve], animations: {
//        titleLabel.text = "3"
//        subtitleLabel.text = "4"
//    }, completion: nil)

//    let labels = [titleLabel, subtitleLabel]
//    labels.forEach { (view) in
//        animate(with: view, closure: {
//            view.text = "3"
//        })
//    }
}
