//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

/* 
 Problem in short: Weak listeners using closures - multithreading/synchronization using GCD.
 
 
 Issue #1: non blocking, asynchronous removeListener() method
 A lot of times our UIViewControllers are playing listener role. So will often get situation deinit is getting called on main queue. Again, a lot of times we do removeListener(listener:) on deinit. Next, for synchronization purposes, we want all our Listanable methods run on single, serial aQueue. The first thought is - we don't want to block the main thread with dispatch_sync so let's do dispatch async.
 
 It won't work, because listener is in the process of deallocation. There is no way to make a weak reference to it also, you would get error like this:
 objc[1507]: Cannot form weak reference to instance (0x141e7de90) of class Module.Class. It is possible that this object was over-released, or is in the process of deallocation.
 
 This issue may arise not only when calling removeListener from deinit, but also when there is a big queue of closures dispatched so that listener dies while waiting for it's turn to be removed (Issue #2)
 
 Solution to Issue #1 and #2: We cannot avoid dispatch_sync in removeListener(listener:) implementation.
 
 Issue #2: Removing self from listeners inside listening closure that is called from notifyListeners()
 
 Due to synchronization, to keep things under control, we want to notify listeners on the same aQueue. But let's see:
 - listeningClosure() call is dispatched async to aQueue
 - listeningClosure() calls removeListener()
 - still running on aQueue, removeListener() dispatches it's code sync to aQueue
 - aQueue gets suspended while in the middle of listeningClosure() execution
 - aQueue waits for removeListener(:) to finish
 - aQueue cannot finish removeListener(:) because it's suspended
 - dead lock
 
 Solution to Issue #3: removeListener() has new argument sync:Bool which defaults to true because usually it is called from deinit. We also add dispatchPrecondition(condition:) to assert that dispatch_sync inside removeListener() is never called from aQueue
 
 */

enum Setup {
    //Bool is whether fixed
    case issue1(Bool)
    case issue2(Bool)
    case issue3(Bool)
    case noIssue
}

let setup = Setup.noIssue

PlaygroundPage.current.needsIndefiniteExecution = true

struct WeakingContainer {
    weak var object : SomeListener?
    typealias Closure = () -> ()
    let listeningClosure : Closure
}

class Listenable {
    private var containers : [WeakingContainer] = []
    private let aQueue = DispatchQueue(label: "holderQueue", qos: .background, attributes: [])
    
    func addListener(listener: SomeListener, listeningClosure: @escaping WeakingContainer.Closure) {
        aQueue.async {
            let weakItem = WeakingContainer(object: listener, listeningClosure: listeningClosure)
            self.containers.append(weakItem)
        }
    }
    
    func removeListener(listener: SomeListener, alreadyOnQueue: Bool = false) {
        let closure = {
            var indexToRemove : Int? = nil
            
            for index in 0..<self.containers.count {
                let weakListener = self.containers[index]
                if let object = weakListener.object {
                    if object === listener {
                        indexToRemove = index
                    }
                }
            }
            
            if let uIndex = indexToRemove {
                _ = self.containers.remove(at: uIndex)
            }
            
            //Next line won't be called if thre
            print("issue1 and issue2 are fixed") //Won't be called if showcase enabled
        }
        
        switch setup {
        case .issue1, .issue2:
            aQueue.async(execute: closure)
            return
        default:
            break
        }
        
        if alreadyOnQueue {
            if #available(iOS 10.0, *) {
                //dispatch_sync is going to be called from
                dispatchPrecondition(condition: .onQueue(aQueue))
            } else {
                // Fallback on earlier versions
            }
            
            closure()
        } else {
            if #available(iOS 10.0, *) {
                //dispatch_sync is going to be called from
                dispatchPrecondition(condition: .notOnQueue(aQueue))
            } else {
                // Fallback on earlier versions
            }
            
            aQueue.sync(execute: closure)
        }
    }
    
    func dispatch(closure: @escaping () -> ()) {
        aQueue.async {
            closure()
        }
    }
    
    func notifyListeners() {
        aQueue.async {
            for container in self.containers {
                if container.object != nil {
                    container.listeningClosure()
                }
            }
        }
    }
    
    deinit {
        print("holder deinit")
    }
}

class SomeListener {
    private let holder : Listenable
    init(holder: Listenable) {
        self.holder = holder
        holder.addListener(listener: self) {
            switch setup {
            case .issue3(let fixed):
                if fixed {
                    self.holder.removeListener(listener: self)
                } else {
                    self.holder.removeListener(listener: self, alreadyOnQueue: true)
                }
            default:
                break
            }
        }
    }
    
    deinit {
        print("item deinit")
        switch setup {
        case .issue1:
            self.holder.removeListener(listener: self)
        default:
            //Do nothing
            break
        }
    }
}

let holder = Listenable()
class Lifecycle {
    var item : SomeListener? = SomeListener(holder: holder)
}

let lifecycle = Lifecycle()

switch setup {
case .issue2:
    holder.dispatch {
        //Simply dispatching something so that removeItem happens later than deinit
        var number = 0
        for i in 1...100000 {
            number += i
        }
    }
    
    holder.removeListener(listener: lifecycle.item!)
default:
    break
}

lifecycle.item = nil
print(lifecycle.item ?? "no item")


