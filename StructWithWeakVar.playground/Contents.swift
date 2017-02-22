//: Playground - noun: a place where people can play

import UIKit

/*
 What if struct with 'let' storage has a weak instance variable, and that variable nullifies?
 */

protocol SomeDelegate: class {
}

class ConcreteDelegate : SomeDelegate {
}

struct SomeStruct {
    weak var delegate: SomeDelegate?
}

var delegateInstance : ConcreteDelegate? = ConcreteDelegate()
let structInstance = SomeStruct(delegate: delegateInstance)
print(structInstance.delegate)
delegateInstance = nil
print(structInstance.delegate)