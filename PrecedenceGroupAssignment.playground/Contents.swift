//: Playground - noun: a place where people can play

import UIKit

struct Object {
    let value: Int
}

precedencegroup FoldedIntoOptionalChaining {
    assignment: true
    associativity: right
}

infix operator ⭐️ :FoldedIntoOptionalChaining
func ⭐️ (left: Int, right: Int) -> Int {
    return left + right
}

let optional: Int? = nil
let nonOptional: Int = 7

(nonOptional + nonOptional)
(optional? ⭐️ nonOptional)
let optionalObject: Object = Object(value: 1)

//(optional + nonOptional)
//(optional? + nonOptional)
(nonOptional ⭐️ optional?)

