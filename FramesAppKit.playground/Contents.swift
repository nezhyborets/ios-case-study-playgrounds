//: Playground - noun: a place where people can play

import Cocoa
import PlaygroundSupport

let view = NSView(frame: NSRect(x: 0, y: 0, width: 320, height: 50))

let firstView = NSView()
firstView.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(firstView)
NSLayoutConstraint.activate([
    firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    firstView.widthAnchor.constraint(equalToConstant: 64),
    firstView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])

let secondView = NSView()
secondView.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(secondView)
NSLayoutConstraint.activate([
    secondView.leadingAnchor.constraint(equalTo: firstView.trailingAnchor),
    secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    secondView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ]
)

view.layout()
view.layoutSubtreeIfNeeded()

firstView.frame
secondView.frame

PlaygroundPage.current.liveView = view