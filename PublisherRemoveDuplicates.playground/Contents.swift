import Combine

let numbers = [0, 1, 2, 3, 2, 3, 3, 4, 4, 4, 4, 0]
let cancellable = numbers.publisher
    .removeDuplicates()
    .sink { print("\($0)", terminator: " ") }

// Prints: "0 1 2 3 4 0"
