import Combine

let publisherA = CurrentValueSubject<Int, Never>(0)
let publisherB = CurrentValueSubject<Int, Never>(0)
Publishers.MergeMany(publisherA, publisherB).sink { (val) in
    debugPrint("val \(val)")
}

publisherA.send(1)
publisherB.send(2)
publisherA.send(3)
publisherB.send(4)
