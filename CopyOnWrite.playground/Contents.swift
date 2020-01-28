import UIKit

struct PhotoSelectionMarkerInput {
    let photoIdentifier: String
    let markForRemoval: Bool
}

class DictBasedSelectionMarker {
    private lazy var dict: [String: Bool] = [:]

    func mark(inputs: [PhotoSelectionMarkerInput]) {
        // 1
        inputs.forEach {
            dict[$0.photoIdentifier] = $0.markForRemoval
        }

        // 2
        let inputsDict = Dictionary(uniqueKeysWithValues: inputs.map { ($0.photoIdentifier, $0.markForRemoval) })
        dict.merge(inputsDict, uniquingKeysWith: { (_, new) in new })
    }
}
