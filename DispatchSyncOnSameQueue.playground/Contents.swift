//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

/*
 Ok so this is pretty straightforward:
 I just want to see what really happens when we dispatch aClosure on aQueue from fromClosure dispatched on the same queue.
 
 TL;DR try: dispatch_sync suspends the calling thread until aClosure finishes. So if you dispatch_sync to a calling thread, you stop the only thread that was able to execute aClosure, thus it will never finish, thus suspended thread will never resume.
 
 By cases:
 1. "async from async" - I think it's obvious that everything runs without problems. Anyway, we can see the order of execution. We see that a aClosure executes after fromClosure as expected.
 
 2. "sync from sync" - the execution stops on _dispatch_barrier_sync_f_slow (you cannot see it in playground, but that's what real project says in backtrace)
    It may obvious that this fails, but I'd like to go "why?":
    We have on thread (associated with aQueue) that executes both blocks. When we dispatch_sync a fromClosure to aQueue - it starts the execution as expected. But then we, still being on aQueue, do dispatch_sync aClosure to the same aQueue, it suspends the execution in the middle of fromClosure until aClosure is finished. But this aQueue that just stopped is the one that we dispatched aClosure to. So there is no way aClosure can finish. I think it's called a "Dead Lock"
 
    Note: it doesn't matter if dispatch_sync(aQueue,aClosure) is the last call in fromClosure or not, the queue gets suspended in the middle of fromClosure anyway
 3. "sync from async" - _dispatch_barrier_sync_f_slow (same as sync from sync)
    Same issue is applied here. We dispatched a fromClosure to an aQueue, and then we dispatched aClosure to same aQueue, so this aQueue is the one that should've execute an aClosure, but since we called it with dispatch_sync - the thread simply stopped.
 
 4. "async from sync" - everything is working fine. Calling thread (in this case is the one that we dispatched 'fromClosure' to) doesn't have to wait for aClosure to execute (because async), so it simply continues executing 'fromClosure', finishes it and starts executing 'aClosure' without any issues
 */

PlaygroundPage.current.needsIndefiniteExecution = true

enum Setup {
    case asyncFromAsync
    case syncFromSync
    case syncFromAsync
    case asyncFromSync
}

let setup = Setup.syncFromAsync
let queue = DispatchQueue(label: "JustAQueue")

switch setup {
case .asyncFromAsync:
    queue.async {
        print("outer async start")
        queue.async {
            print("inner async")
        }
        print("outer async end")
    }
case .syncFromSync:
    queue.sync {
        print("outer sync start")
        queue.sync {
            print("inner sync")
        }
        print("outer sync end")
    }
case .syncFromAsync:
    queue.async {
        print("async start")
        queue.sync {
            print("sync")
        }
        print("async end")
    }
case .asyncFromSync:
    queue.sync {
        print("async start")
        queue.async {
            print("sync")
        }
        print("async end")
    }
}
