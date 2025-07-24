//
//  CellForAddTeaview.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import SwiftUI

struct CellForAddTeaview: View {
    let tea: TeaEmtry
    let tapToAdd: () -> Void
    var isInclude: Bool = false
    
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
                .frame(height: 60)
            HStack() {
                
                HStack(alignment: .center, spacing: 12) {
                    Image(systemName: "cup.and.saucer.fill")
                    Text(tea.name ?? "no name")
                        .font(.headline)
                    
                    Spacer()
                    
                    
                    Button {
                        tapToAdd()
                    } label: {
                        Image(systemName: isInclude ? "checkmark.square.fill" : "square")
                    }
                }
            }.padding()
        }
        .foregroundStyle(.black)
        .padding()
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}


#Preview {
    CellForAddTeaview(tea: TeaEmtry(context: CDTeaManager.instance.context), tapToAdd: {})
}
