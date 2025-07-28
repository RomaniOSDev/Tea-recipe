//
//  CoreDataManager.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//


import CoreData


final class CDTeaManager {
    static let instance = CDTeaManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "Tea")
        container.loadPersistentStores { descption, error in
            if let error = error{
                print("Error looading core data\(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        }catch let error {
            print("Save data erroe \(error.localizedDescription)")
        }
        
    }
    
    func deleteAllData() {
        let entities = container.managedObjectModel.entities
        for entity in entities {
            if let entityName = entity.name {
                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                
                do {
                    try context.execute(deleteRequest)
                    try context.save()
                } catch let error {
                    print("Error deleting \(entityName): \(error.localizedDescription)")
                }
            }
        }
        
        // Сбрасываем контекст после удаления
        context.reset()
    }
}
