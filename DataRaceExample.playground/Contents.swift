//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport

var str = "Hello, playground"

let readQueue = DispatchQueue(label: "queue1")
let writeQueue = DispatchQueue(label: "queue2")

class SampleClass {
    var field1 : Int = 0
    var field2 : Int = 0
}

var mutableArray : [SampleClass] = []

for i in 1..<100 {
    let sampleObject = SampleClass()
    sampleObject.field1 = i
    sampleObject.field2 = i
    mutableArray.append(sampleObject)
}

var evidences : [String] = []

writeQueue.async {
    for (i, sampleObject) in mutableArray.enumerated() {
        sampleObject.field1 -= i
        evidences.append("\(i) write1 finished")
        sampleObject.field2 -= i
        evidences.append("\(i) write2 finished")
    }
}

var results : [String] = []
readQueue.async {
    for (i,sampleObject) in mutableArray.enumerated() {
        let string = "\(sampleObject.field1) \(sampleObject.field2)"
        results.append(string)
        evidences.append("\(i) read finished")
    }
}

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    print(results.joined(separator: "\n"))
    print(evidences.joined(separator: "\n"))
}

PlaygroundPage.current.needsIndefiniteExecution = true