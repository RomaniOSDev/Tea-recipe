//
//  CollectionOpenView.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import SwiftUI

struct CollectionOpenView: View {
    @StateObject var vm: CollectionViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.mainBack.ignoresSafeArea()
            if let collection = vm.simpleCollection{
                
                
                VStack(spacing: 20){
                    HStack{
                        Button {
                            vm.presenetCollection.toggle()
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        Spacer()
                        Text("\(collection.name ?? "")")
                            .font(.headline)
                        Spacer()
                        
                        Button {
                            
                            vm.deleteCollection(collection)
                            dismiss()
                        } label: {
                            Text("Delete")
                                .foregroundStyle(.red)
                        }
                    }
                    .foregroundStyle(.white)
                    
                    ScrollView {
                        if let teas = collection.tea?.allObjects as? [TeaEmtry], !teas.isEmpty {
                            ForEach(teas) { tea in
                                CellForCollectionTEeaView(tea: tea)
                            }
                        } else {
                            Text("No teas in this collection")
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                }.padding()
            }
        }
    }
}

#Preview {
    CollectionOpenView(vm: CollectionViewModel())
}
