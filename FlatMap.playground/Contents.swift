//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

let optionalInt : Int? = 42
let optionalIntFlattened = optionalInt.flatMap { $0 }
optionalIntFlattened //Still optional

let optionalNilInt : Int? = nil
let optionalNilIntFlattened = optionalNilInt.flatMap { $0 }
optionalNilIntFlattened

let flatInts = [1,2,3,4,5,6]
let flatIntsFlattened = flatInts.flatMap { $0 }
flatIntsFlattened

let flatOptionalInts : [Int?] = [1,2,nil,4,nil,6]
let flatOptionalIntsFlattened = flatOptionalInts.flatMap { $0 }
flatOptionalIntsFlattened

let nestedArrays = [[1,2,3],[4,5,6]]
let nestedArraysFlattened = nestedArrays.flatMap { $0 }
nestedArraysFlattened

let arrayOfDicts : [[String : Any]] = [["Value" : "a"], ["Value" : "b"]]
let arrayOfDictsFlattened = arrayOfDicts.flatMap { $0 }
arrayOfDictsFlattened //Results in array of tuples (key, value)

let arrayOfDictsConvertedAndFlattened = arrayOfDicts.flatMap { _ in return ["asd1", "asd2"] }
arrayOfDictsConvertedAndFlattened