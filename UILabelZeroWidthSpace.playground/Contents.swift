//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

/*
 UILabel trims tail empty space if textAlignment = .right
 */

class ViewController:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()

        let valueLabel = UILabel()
        valueLabel.layer.borderWidth = 1
        valueLabel.layer.cornerRadius = 4
        valueLabel.textAlignment = .left
        view.addSubview(valueLabel)
        valueLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        valueLabel.textAlignment = .right
        valueLabel.text = "   A   "
        //valueLabel.text = "  ASDAAAAA   \u{0020}" //Not working at all
        //valueLabel.text = "  ASDAAAA \u{205F}"
        //valueLabel.text = "  ASD \u{200B}" //Working in iOS9
        //valueLabel.text = "  ASDAAAAA \u{0009}" //Working in iOS10, but space is different for different text lenght, maybe because 0009 is actually a TAB not a space

        self.view.backgroundColor = UIColor.red
    }

}

let viewController = ViewController()
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true
