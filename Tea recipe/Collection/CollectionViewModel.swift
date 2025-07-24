//
//  CollectionViewModel.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import Foundation
import CoreData

final class CollectionViewModel: ObservableObject {
    let manager = CDTeaManager.instance
    
    @Published var teas: [TeaEmtry] = []
    @Published var collectionTea: [CollectionTea] = []
    
    @Published var simpleCollection: CollectionTea?
    @Published var simpleCollectionTea: [TeaEmtry] = []
    @Published var simpleCollectionName: String = ""
    @Published var presentTeam: Bool = false
    @Published var presenetCollection: Bool = false
    
    init(){
        fetchTeas()
        fetchCollectionTeas()
    }
    
    func deleteCollection(_ collection: CollectionTea) {
        manager.context.delete(collection)
        saveData()
    }
    
    
    
    func saveCollection() {
        let newCollectionTea = CollectionTea(context: manager.container.viewContext)
        newCollectionTea.name = simpleCollectionName
        if var teasforcollection = newCollectionTea.tea?.allObjects as? [TeaEmtry] {
            
            for tea in simpleCollectionTea {
                teasforcollection.append(tea)
            }
            newCollectionTea.tea = Set(teasforcollection) as NSSet
        }
       print(newCollectionTea)
        saveData()
        clearSimpleCollection()
    }
    
    func clearSimpleCollection() {
        simpleCollectionTea.removeAll()
        simpleCollectionName = ""
    }
    
    func checkInSimpleCollection(_ tea: TeaEmtry) -> Bool {
        return simpleCollectionTea.contains(where: { $0.name == tea.name })
    }
    
    func addForSimpleCollection(_ tea: TeaEmtry) {
        if simpleCollectionTea.contains(where: { $0.name == tea.name }) {
            simpleCollectionTea.removeAll(where: { $0.name == tea.name })
        }else{
            simpleCollectionTea.append(tea)
        }
        
    }
    
    func fetchTeas() {
        let request = NSFetchRequest<TeaEmtry>(entityName: "TeaEmtry")
        do {
            teas = try manager.container.viewContext.fetch(request)
        }catch {
            print(error)
        }
    }
    
    func fetchCollectionTeas() {
        let request: NSFetchRequest<CollectionTea> = CollectionTea.fetchRequest()
        do {
            collectionTea = try manager.container.viewContext.fetch(request)
        }catch {
            print(error)
        }
    }
    
    func saveData() {
        teas.removeAll()
        collectionTea.removeAll()
        manager.save()
        fetchTeas()
        fetchCollectionTeas()
    }
}
