//
//  CellForCollectionview.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import SwiftUI

struct CellForCollectionview: View {
    let collection: CollectionTea
    let tapToOpen: () -> Void
    let tapToDelete: () -> Void
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(.white)
                .opacity(0.1)
                .cornerRadius(20)
            
                .frame(height: 110)
            VStack{
                HStack() {
                    Image(systemName: "folder.fill")
                        .foregroundStyle(.pink)
                    
                    Text(collection.name ?? "no name")
                        .font(.headline)
                    
                    Spacer()
                    Button {
                        tapToDelete()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                    }
                }
                .font(.headline)
                .foregroundStyle(.white)
                HStack{
                    if let tea = collection.tea?.allObjects as? [TeaEmtry] {
                        Text("\(tea.count) teas")
                            .font(.headline)
                    }
                    Spacer()
                    
                    Button {
                        tapToOpen()
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                    
                }.foregroundStyle(.white)
                
            }.padding()
        }
        .foregroundStyle(.black)
        .padding()
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    ZStack {
        Color.mainBack
        CellForCollectionview(collection: CollectionTea(context: CDTeaManager.instance.context), tapToOpen: {}, tapToDelete: {})
    }
}
