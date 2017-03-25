//: Playground - noun: a place where people can play

import UIKit

struct SomeStruct {

}

/* 
 Structs cannot inherit, so will get an error:
 "Inheritance from non-protocol type 'SomeStruct'
 */
//struct SomeStructExtended : SomeStruct {
//
//}

let anyStruct : Any = SomeStruct()  
if let someStruct = anyStruct as? SomeStruct {

}
