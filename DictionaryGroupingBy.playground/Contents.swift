import UIKit

let ids = ["asd", "asd"]

let dict = Dictionary(grouping: ids, by: { $0 })
print(dict)
