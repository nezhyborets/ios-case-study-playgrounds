//
//  TestEntity+CoreData.swift
//  CoreDataSaveWithoutChangesConflict
//
//  Created by Nezhyborets Oleksii on 12/26/19.
//  Copyright © 2019 nezhyborets. All rights reserved.
//

extension SomeEntity {
    public override func willSave() {
        super.willSave()

        print("willSave changed keys \(changedValues().keys), moc \(managedObjectContext!)")
    }
}
