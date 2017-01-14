//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

/* 
 This empty Error protocol blows my mind, so I'm answering my own questions here.
 Question 1:
 Since "error as NSError" is allowed by default, what actually happens when we do that?
 First of all here is SO thread discussing almost same question:
 http://stackoverflow.com/questions/31422005/converting-errortype-to-nserror-loses-associated-objects
 */

func print(nsError: NSError) {
    print("domain - \(nsError.domain)")
    print("code - \(nsError.code)")
    print("localizedDescription - \(nsError.localizedDescription)")
    print("localizedRecoveryOptions - \(nsError.localizedRecoveryOptions)")
    print("localizedRecoverySuggestion - \(nsError.localizedRecoverySuggestion)")
    print("localizedFailureReason - \(nsError.localizedFailureReason)")
    print("userInfo - \(nsError.userInfo)")
}

/* ------------------------Enum - Error-------------------------
 First try to answer Question 1: seeing what we get as in NSError from a simple enum conforming to Error protocol
 */
enum MyErrorEnum : Error { case test }
let error = MyErrorEnum.test
let nsError = error as NSError
print(nsError: nsError)
/* Output for NSError from simple one case enum:
 
 domain - MyError
 code - 0
 localizedDescription - The operation couldn’t be completed. (MyError error 0.)
 localizedRecoveryOptions - nil
 localizedRecoverySuggestion - nil
 localizedFailureReason - nil
 userInfo - [:]
 
 Interesting NOTE: It seems when we call localizedDescription on instance conforming to Error - it simply does 'error as NSError' implicitly and gives us a localizedDescription of that nsError
 */

print("error.localizedDescription - \(error.localizedDescription)")
/* error.localizedDescription - The operation couldn’t be completed. (MyError error 0.) - (output is just the same we've just seen) */

/* ----------------------Struct : Error------------------------
 Secondly, let's see what we get for same approach but with empty struct instead of enum. Surprisingly but we get a bit different results.
 */
struct EmptyErrorStruct : Error { }

let errorStruct = EmptyErrorStruct()
let nsErrorFromStruct = errorStruct as NSError
print(nsError: nsErrorFromStruct)
/* Output for NSError from an empty struct conforming to Error:
 (Note the CODE is 1, not 0 as in enum)
 
 domain - EmptyErrorStruct
 code - 1
 localizedDescription - The operation couldn’t be completed. (EmptyErrorStruct error 1.)
 localizedRecoveryOptions - nil
 localizedRecoverySuggestion - nil
 localizedFailureReason - nil
 userInfo - [:]
 */

/* ----------------------Class : Error--------------------------
 It gets even more interesting with Classes! 
 */
class EmptyErrorClass : Error { }

let errorClass = EmptyErrorClass()
/* WTFs:
 1. Trying to cast class that conforms to Error to an NSError simply gives us Complile error:
 
 let nsErrorFromClass = errorClass as NSError
 Error: Cannot convert value of type 'EmptyErrorClass' to type 'NSError' in coercion
 
 2. If we try to force unwrap it - we get a warning:
 
 let nsErrorFromClass = errorClass as! NSError
 Warning: Cast from 'EmptyErrorClass' to unrelated type 'NSError' always fails
 
 And then it actually crashes in runtime
 Lets just hide it so compiler doesn't know it's a class
 */

let classyErrorHidden : Error = EmptyErrorClass()
let nsErrorFromClassyHidden = classyErrorHidden as NSError
print(nsError: nsErrorFromClassyHidden)
/* The output is the same as for Struct except domain - EmptyErrorClass. Expected, not fun. */

/* ---------------------Real NSError----------------------------
 Lets try to get an Apple Generated NSError
 */
let url = URL(fileURLWithPath: "what!$#^%$@Y$&&")
do {
    let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
} catch let error {
    let realNsError = error as NSError
    print(nsError: realNsError)
    PlaygroundPage.current.finishExecution()
}

/* Output for a real NSError:
 domain - NSCocoaErrorDomain
 code - 260
 localizedDescription - The file “what!$#^%$@Y$&&” couldn’t be opened because there is no such file.
 localizedRecoveryOptions - nil
 localizedRecoverySuggestion - nil
 localizedFailureReason - Optional("The file doesn’t exist.")
 userInfo - [AnyHashable("NSURL"): what!$%23%5E%25$@Y$&& -- file:///private/var/folders/5q/l8ylk7zn7bdb1hllg10b36fw0000gn/T/com.apple.dt.Xcode.pg/containers/com.apple.dt.playground.stub.iOS_Simulator.ErrorToNSError-823F546B-0DBA-4D75-86AA-6465C65615C6/, AnyHashable("NSFilePath"): /private/var/folders/5q/l8ylk7zn7bdb1hllg10b36fw0000gn/T/com.apple.dt.Xcode.pg/containers/com.apple.dt.playground.stub.iOS_Simulator.ErrorToNSError-823F546B-0DBA-4D75-86AA-6465C65615C6/what!$#^%$@Y$&&, AnyHashable("NSUnderlyingError"): Error Domain=NSPOSIXErrorDomain Code=2 "No such file or directory"]
 */

