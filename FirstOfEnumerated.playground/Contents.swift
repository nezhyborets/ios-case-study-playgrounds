import UIKit

var str = "Hello, playground"

print([0, 3, 1, 3, 2, 3, 4, 3, 5, 3].enumerated().first(where: { $0.element == 3 })?.offset)
