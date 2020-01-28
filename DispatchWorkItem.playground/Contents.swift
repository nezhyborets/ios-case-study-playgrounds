import UIKit

let dispatchWorkItem = DispatchWorkItem {
    print("wat")
}

DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: dispatchWorkItem)
dispatchWorkItem.cancel()
