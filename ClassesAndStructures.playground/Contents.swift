//: Playground - noun: a place where people can play

import UIKit

struct SomeStruct {

}

/*
 1) Structs cannot inherit, so will get an error:
 "Inheritance from non-protocol type 'SomeStruct'
 */
//struct SomeStructExtended : SomeStruct {
//
//}

let anyStruct : Any = SomeStruct()  
if let someStruct = anyStruct as? SomeStruct {

}

/*
 2) Arrays can contain optional
 */
let arrayOfOptional : [Int?] = []