//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

"2".compare("1", options: .numeric) == .orderedDescending
"1.2".compare("1.1", options: .numeric) == .orderedDescending
"1.0.10".compare("1.0.9", options: .numeric) == .orderedDescending
"1.1.0".compare("1.1", options: .numeric) == .orderedDescending
