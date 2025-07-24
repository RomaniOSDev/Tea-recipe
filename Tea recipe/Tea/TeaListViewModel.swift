//
//  TeaListViewModel.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import Foundation
import CoreData
import UIKit

enum ColorTea: String, CaseIterable {
    case pink
    case red
    case green
    case yellow
    case blue
    case white
    case purple
    case orange
    
    var color: UIColor {
        switch self {
        case .pink: return .systemPink
        case .red: return .red
        case .green: return .green
        case .yellow: return .yellow
        case .blue: return .blue
        case .white: return .white
        case .purple: return .purple
        case .orange: return .orange
        }
    }
}

final class TeaListViewModel: ObservableObject {
    
    let manager = CDTeaManager.instance
    @Published var teas: [TeaEmtry] = []
    
    @Published var isLoading: Bool = false
    @Published var simplrColor: ColorTea = .white
    @Published var simpleName: String = ""
    @Published var simplrBrewingTime: String = ""
    @Published var simpleBrewingTemp = ""
    @Published var simpleNote: String = ""
    @Published var simpleBestPaired = ""
    
    init() {
        loadTeas()
    }
    
    func deleteTea(_ tea: TeaEmtry) {
        manager.context.delete(tea)
        saveContext()
    }
    
    func addFavorite(_ tea: TeaEmtry) {
        tea.isFavorite = true
        saveContext()
    }
    
    func loadTeas() {
        isLoading = true
        let request = NSFetchRequest<TeaEmtry>(entityName: "TeaEmtry")
        do {
            teas = try manager.container.viewContext.fetch(request)
            isLoading = false
        }catch {
            print(error)
        }
    }
    
    func addTea() {
        let newTea = TeaEmtry(context: manager.context)
        newTea.name = simpleName
        newTea.brewingTime = Int32(simplrBrewingTime) ?? 0
        newTea.brewingTemp = Int32(simpleBrewingTemp) ?? 0
        newTea.notes = simpleNote
        newTea.bestPaired = simpleBestPaired
        
        // Улучшенная сериализация цвета
        do {
            let colorData = try NSKeyedArchiver.archivedData(
                withRootObject: simplrColor.color,
                requiringSecureCoding: true
            )
            newTea.color = colorData
            print("Цвет успешно сохранен:", simplrColor.color.rgbaDescription)
        } catch {
            print("Ошибка сохранения цвета:", error)
            newTea.color = nil
        }
        
        saveContext()
    }
    
    func clerdata() {
        simpleName = ""
        simplrBrewingTime = ""
        simpleBrewingTemp = ""
        simpleNote = ""
        simpleBestPaired = ""
    }
    
    private func saveContext() {
        teas.removeAll()
        manager.save()
        loadTeas()
        clerdata()
    }
}

extension UIColor {
    func toData() -> Data? {
        do {
            return try NSKeyedArchiver.archivedData(
                withRootObject: self,
                requiringSecureCoding: true
            )
        } catch {
            print("Ошибка архивации цвета:", error.localizedDescription)
            return nil
        }
    }

    static func fromData(_ data: Data) -> UIColor? {
        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
    }
}

extension UIColor {
    var rgbaDescription: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return String(format: "R: %.2f, G: %.2f, B: %.2f, A: %.2f", red, green, blue, alpha)
    }
}


