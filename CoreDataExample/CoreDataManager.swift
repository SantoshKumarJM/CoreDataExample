//
//  CoreDataManager.swift
//  CoreDataExample
//
//  Created by Santosh on 27/10/20.
//  Copyright © 2020 Santosh. All rights reserved.
//

import UIKit
import CoreData

struct userInformationModel {
    let mobile: String
    let userName: String
}

class CoreDataManager {
    //1
    static let shared = CoreDataManager()
    //2
    let managedContext = appDelegate.persistentContainer.viewContext
    //3
    func fetchEntity(_ classObject: AnyClass) -> [Any] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: NSStringFromClass(classObject.self))
        var result: [Any]? = nil
        do {
            result = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return result!
    }
    //4
    func saveEntity() {
        do {
            try managedContext.save()
            print("✅ saved succesfuly")
        } catch let error as NSError {
            print("❌ Failed to create : \(error.localizedDescription)")
        }
    }
    
    
    func saveUserInfo(_ model: userInformationModel) {
        let information = NSEntityDescription.insertNewObject(forEntityName: NSStringFromClass(UserInfoEntity.self), into: managedContext) as! UserInfoEntity
        information.userName = model.userName
        information.phoneNumer = model.mobile
        //
        saveEntity()
    }
}
