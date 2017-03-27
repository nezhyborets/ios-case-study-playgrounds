//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class Reference {
}

struct Value {
    
}

class TestClass : NSObject {
    var someReference = Reference()
    var someValue = Value()
}

let testObject = TestClass()

func dispatch(label: String) {
    let queue = DispatchQueue(label: label, attributes: .concurrent)
    queue.async {
        DispatchQueue.concurrentPerform(iterations: 10000000, execute: { (i) in
//            testObject.someReference = Reference()
            testObject.someValue = Value()
        })
    }
}

for i in [0...30] {
    dispatch(label: "queue\(i)")
}

PlaygroundPage.current.needsIndefiniteExecution = true