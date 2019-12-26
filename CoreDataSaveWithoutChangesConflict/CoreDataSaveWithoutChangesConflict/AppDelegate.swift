//
//  AppDelegate.swift
//  CoreDataSaveWithoutChangesConflict
//
//  Created by Nezhyborets Oleksii on 12/26/19.
//  Copyright © 2019 nezhyborets. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        _ = self.persistentContainer

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CoreDataSaveWithoutChangesConflict")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }

            DispatchQueue.main.async {
                self.test()
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func test() {
        let moc = persistentContainer.viewContext
        let id = "testId"
        let attributed = "testAttribute"

        let fetchRequest: NSFetchRequest<SomeEntity> = SomeEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "id == %@", id)

        var object: SomeEntity
        if let storedObject = try? moc.fetch(fetchRequest).first {
            object = storedObject
        } else {
            object = SomeEntity(context: moc)
        }

        var isDifferent = false

        if object.id != id {
            isDifferent = true
        }

        object.id = id
        try! moc.save()

        for i in 0..<1000 {
            let moc = persistentContainer.newBackgroundContext()
            moc.perform {
                var object: SomeEntity
                if let storedObject = try? moc.fetch(fetchRequest).first {
                    object = storedObject
                } else {
                    object = SomeEntity(context: moc)
                }

                if object.testAttribute != attributed {
                    isDifferent = true
                }

                object.testAttribute = "testAttribute"

                print("isDifferent \(isDifferent)")
                print("moc.hasChanges \(moc.hasChanges)")

                do {
                    try moc.save()
                } catch {
                    print("save error \(error)")
                }
            }
        }
    }
}

