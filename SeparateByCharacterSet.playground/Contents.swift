//: Playground - noun: a place where people can play

import UIKit

var str = "John,"

let characterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
let separated = str.components(separatedBy: characterSet)
