import UIKit
import Combine

let subject = CurrentValueSubject<Int, Never>(0)
subject.sink { (newVal) in
    print("newVal \(newVal)")
}

let erasedSubject = subject.eraseToAnyPublisher()
erasedSubject.sink { (newVal) in
    print("erasedSubject newVal \(newVal)")
}

var published = Published(initialValue: 1)
published.projectedValue.sink { (newVal) in
    print("published newVale \(newVal)")
}

let erasedPublished = published.projectedValue.eraseToAnyPublisher()
erasedPublished.sink { (newVal) in
    print("erasedPublished newVal \(newVal)")
}
