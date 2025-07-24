//
//  CellForTeaView.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import SwiftUI

struct CellForTeaView: View {
    let tea: TeaEmtry
    let tapFavorite: () -> Void
    let tapDelete: () -> Void
    @State private var expanded = false
    
    private func colorFromData(_ data: Data?) -> Color {
        guard let data = data else { return .gray }
        
        if let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) {
        return Color(uiColor)
        }
       
        return .gray
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(colorFromData(tea.color))
            
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            VStack(alignment: .leading, spacing: 8) {
                
                HStack(alignment: .center, spacing: 12) {
                    Image(systemName: "cup.and.saucer.fill")
                    VStack(alignment: .leading, spacing: 4) {
                        Text(tea.name ?? "no name")
                            .font(.headline)
                        HStack(spacing: 12) {
                            Text("\(tea.brewingTemp)°C")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("\(tea.brewingTime) min")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    Spacer()
                    VStack {
                        Menu("...") {
                            Button {
                                tapFavorite()
                            } label: {
                                Text("Change favorite")
                            }
                            
                            Button {
                                tapDelete()
                            } label: {
                                Text("Delete")
                                    .foregroundStyle(.red)
                            }

                        }

                        
                        Button(action: { expanded.toggle() }) {
                            Image(systemName: expanded ? "chevron.up" : "chevron.down")
                                .foregroundStyle(.black)
                                .padding(8)
                        }
                    }
                }
                if expanded {
                    if let notes = tea.notes, !notes.isEmpty {
                        Text("Brewing Notes: \(notes)")
                            .font(.body)
                            .foregroundStyle(.black)
                    }
                    if let bestPaired = tea.bestPaired, !bestPaired.isEmpty {
                        Text("Best Paired With: \(bestPaired)")
                            .font(.body)
                            .foregroundStyle(.black)
                    }
                }
            }
            .foregroundStyle(.black)
            .padding()
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
    }
}


