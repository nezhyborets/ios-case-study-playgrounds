//: Playground - noun: a place where people can play

import UIKit

/*
 1
 */
protocol PAT {
    associatedtype AssociatedType
    func doSomething(with: AssociatedType)
}

class ConformingToPAT : PAT {
    typealias AssociatedType = String
    func doSomething(with: String) {

    }
}

//let patInstance : PAT = ConformingToPAT() //Gives error
let concreteInstance : ConformingToPAT = ConformingToPAT()

/*
 2
 */

protocol TypeConstraint {
    func typeConstraintMethod()
}

protocol ExtendedTypeConstraint {
    func extendedTypeConstraintMethod()
}

protocol ProtocolWithGenericFunction {
    func someGenericFunction<T: TypeConstraint>(with: T)
}

/* Gives an error
struct ConcreteTypeWithExtendedTypeConstraint : ProtocolWithGenericFunction {
    func someGenericFunction<T : ExtendedTypeConstraint>(with: T) {

    }
}
 */

/* 
 2.1 Trying to use PAT to extend generic type
 */

protocol PATConstrained {
    associatedtype ConstrainedAssociatedType : TypeConstraint
    func doSomething(with: ConstrainedAssociatedType)
}

struct ConformingToTypeConstraint : TypeConstraint {
    func typeConstraintMethod() {

    }
}

struct ConformingToExtendedTypeConstraint : ExtendedTypeConstraint {
    func extendedTypeConstraintMethod() {

    }
}

struct ConformingToPATConstrained : PATConstrained {
    internal func doSomething(with: ConformingToTypeConstraint) {

    }

    typealias ConstrainedAssociatedType = ConformingToTypeConstraint
}

/* Gives an error
struct ConformingToPATConstrainedWithExtendedType : PATConstrained {
    internal func doSomething(with: ConformingToExtendedTypeConstraint) {

    }

    typealias ConstrainedAssociatedType = ConformingToExtendedTypeConstraint
}
 */

/* 
 3. Type erasure
 */


