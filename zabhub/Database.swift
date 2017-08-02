//
//  Database.swift
//  database
//
//  Created by ZabHub Team on 5/12/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class Database {
    var entityName: String
    var context: NSManagedObjectContext {
        get {
            return (
                UIApplication.shared.delegate as!AppDelegate
            ).persistentContainer.viewContext
        }
    }
    
    init(entityName: String) {
        self.entityName = entityName
    }

    func add(data: [String: Any], save: Bool?=true) {
        /***
            Add given `data` to the given `entityName` table.
         
            Usage Guide:
         
            Usage #1 (recommended).
            let database = Database(entityName: "TABLE_NAME")
            database.add([
                "name": "Talha Ashraf",
                "age": 14,
                "address": "ammi abbu ka gher :D",
            ])
         
            Usage #2.
            let database = Database(entityName: "TABLE_NAME")
            database.add([
                "name": "Talha Ashraf",
                "age": 14,
                "address": "ammi abbu ka gher :D",
            ], save=false)
            database.save()
        ***/
        self.getEntity().setValuesForKeys(data)

        // Save data to the database if `save` to true.
        // Default value of `save` is true.
        if save == true {
            self.save()
        }
    }
    
    func update(row: Int, data: [String: Any], save: Bool?=true) {
        /***
            Update given `data` at given `row` number to the given `entityName` table.
         
            Usage Guide:
         
            Usage #1 (recommended).
            let database = Database(entityName: "TABLE_NAME")
            database.update([
                "name": "Talha Ashraf",
            ])
         
            Usage #2.
            let database = Database(entityName: "TABLE_NAME")
            database.add([
                "name": "Talha Ashraf",
            ], save=false)
            database.save()
        ***/
        do {
            var rows = try self.context.fetch(self.getNSFetchRequest())
            if rows.count > 0 {
                rows[row].setValuesForKeys(data)
            }
        } catch let error as NSError {
            print("Cannot save \(error), \(error.userInfo)")
        }
        
        
        // Save data to the database if `save` to true.
        // Default value of `save` is true.
        if save == true {
            self.save()
        }
    }
    
    func remove(row: Int, save: Bool?=true) {
        /***
            Remove data at given `row` number.
         
            Usage Guide:
         
            Usage #1 (recommended):
            let database = Database(entityName: "TABLE_NAME")
            database.remove(0)
         
            Usage #2:
            let database = Database(entityName: "TABLE_NAME")
            database.remove(0, save=false)
         	database.save()
         ***/
        do {
            var rows = try self.context.fetch(self.getNSFetchRequest())
            if rows.count > 0 {
                self.context.delete(rows[row])
            }
        } catch let error as NSError {
            print("Cannot save \(error), \(error.userInfo)")
        }
        
        
        // Save data to the database if `save` to true.
        // Default value of `save` is true.
        if save == true {
            self.save()
        }
    }
    
    func delete(save: Bool?=true) {
        /***
            Delete all rows of given `entityName` table.
         
            Usage Guide:
            
            Usage #1 (recommended):
            let database = Database(entityName: "TABLE_NAME")
            database.delete()
         
            Usage #2:
            let database = Database(entityName: "TABLE_NAME")
            database.delete(save=false)
            database.save()
        ***/
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
            entityName: self.entityName)
        let batchDeleteRequest = NSBatchDeleteRequest(
            fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
        } catch let error as NSError {
            print("Cannot save \(error), \(error.userInfo)")
        }
        
        // Save data to the database if `save` to true.
        // Default value of `save` is true.
        if save == true {
            self.save()
        }
    }
    
    func save() {
        /* Save data to the given `entityName` table */
        do {
            try self.context.save()
        } catch let error as NSError {
            print("Cannot save \(error), \(error.userInfo)")
        }
    }
    
    func getEntity() -> NSManagedObject {
        /* Get table entity */
        return NSManagedObject(
            entity: self.getNSEntityDescription(),
            insertInto: self.context
        )
    }
    
    func getNSEntityDescription() -> NSEntityDescription! {
        return NSEntityDescription.entity(
            forEntityName: self.entityName,
            in: self.context
        )
    }
    
    func getNSFetchRequest() -> NSFetchRequest<NSManagedObject> {
        return NSFetchRequest<NSManagedObject>(entityName: self.entityName)
    }
    
    func getContext() -> NSManagedObjectContext {
        /* Return application context */
        return self.context
    }
}
