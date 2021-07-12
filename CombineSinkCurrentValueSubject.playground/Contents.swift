import UIKit
import Combine

let valueSubject = CurrentValueSubject<Int, Never>(1)
valueSubject.sink { [weak valueSubject] (newValue) in
    debugPrint("newValue \(newValue), currentValue \(valueSubject?.value)")
}
debugPrint("set")
valueSubject.value = 2
debugPrint("send")
valueSubject.value = 3
