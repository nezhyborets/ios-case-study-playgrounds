//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct WeakItem {
    weak var item : Item?
}

class Holder {
    private var items : [WeakItem] = []
    private let queue = DispatchQueue(label: "holderQueue", qos: .background, attributes: [])
    
    func addItem(item: Item) {
        print("adding item")
        queue.async {
            let weakItem = WeakItem(item: item)
            self.items.append(weakItem)
            print("added item")
        }
    }
    
    func removeItem(item: Item) {
        print("removing item \(item)")
        queue.async { [weak weakItem = item] in
            print("\"remove item\" evaluation started")
            if let uItem = weakItem {
                
                var indexToRemove : Int? = nil
                
                for index in 0..<self.items.count {
                    let weakItem = self.items[index]
                    if weakItem.item === uItem {
                        indexToRemove = index
                    }
                }
                
                if let uIndex = indexToRemove {
                    self.items.remove(at: uIndex)
                }
            } else {
                
            }
        }
        print("\"remove\" dispatched")
    }
    
    func dispatch(closure: @escaping () -> ()) {
        print("adding custom block")
        queue.async {
            print("evaluating custom block started")
            closure()
            print("evaluating custom block finished")
        }
    }
    
    deinit {
        print("holder deinit")
    }
}

class Item {
    private let holder : Holder
    init(holder: Holder) {
        self.holder = holder
        holder.addItem(item: self)
    }
    
    deinit {
        print("item deinit")
//        holder.removeItem(item: self)
    }
}

let holder = Holder()
class Lifecycle {
    var item : Item? = Item(holder: holder)
}

let lifecycle = Lifecycle()
holder.dispatch {
    //Simply dispatching something so that removeItem happens later than deinit
    var number = 0
    for i in 1...100000 {
        number += i
    }
}
holder.removeItem(item: lifecycle.item!)
lifecycle.item = nil
print(lifecycle.item ?? "no item")


