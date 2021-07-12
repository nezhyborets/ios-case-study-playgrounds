import UIKit
import Combine

let pub1 = CurrentValueSubject<Int, Never>(0)
let pub2 = CurrentValueSubject<Float, Never>(0)
let pub3 = CurrentValueSubject<Double, Never>(0)

let any = pub1
    .combineLatest(pub2, { _, _ in () })
    .combineLatest(pub3, { _, _ in () })
any.sink {
    debugPrint("asd \($0)")
}

pub3.send(1)
