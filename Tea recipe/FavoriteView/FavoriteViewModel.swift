//
//  FavoriteViewModel.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import Foundation
import CoreData

final class FavoriteViewModel: ObservableObject {
    let manager = CDTeaManager.instance
    
    @Published var favoriteTeas: [TeaEmtry] = []
    
    init() {
        fetchFavoriteTeas()
    }
    
    func fetchFavoriteTeas() {
        let request = NSFetchRequest<TeaEmtry>(entityName: "TeaEmtry")
        
        do {
            favoriteTeas = try manager.container.viewContext.fetch(request)
            favoriteTeas = favoriteTeas.filter { $0.isFavorite}
        }catch {
            print(error)
        }
    }
    
    func deleteTea(_ tea: TeaEmtry) {
        manager.context.delete(tea)
        saveContext()
    }
    
    func addFavorite(_ tea: TeaEmtry) {
        tea.isFavorite = false
        saveContext()
    }
    
    func saveContext() {
        favoriteTeas.removeAll()
        manager.save()
        fetchFavoriteTeas()
    }
}
