//
//  NewCollectionView.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import SwiftUI

struct NewCollectionView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: CollectionViewModel
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.mainBack.ignoresSafeArea()
            VStack(spacing: 20){
                CustonTextField(title: "Collection name",
                                placeholder: "e.g. For family tea parties",
                                text: $vm.simpleCollectionName)
                
                ScrollView {
                    Button {
                        vm.presentTeam.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.darkBlue)
                            HStack {
                                Image(systemName: "plus")
                                    
                                Text("Add tea")
                                    
                                    .padding(10)
                            }.foregroundStyle(.white)
                        }
                    }
                    ForEach(vm.simpleCollectionTea) { tea in
                        CellForAddTeaview(tea: tea, tapToAdd: {}, isInclude: true)
                            .focused($isFocused)
                    }
                    
                }
                
            }.padding()
        }
        .onTapGesture {
            isFocused = false
        }
        .sheet(isPresented: $vm.presentTeam, content: {
            AddTeaForCollectionView(vm: vm)
        })
        .navigationBarItems(leading: Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(.gray)
        }))
        .navigationBarItems(trailing: Button(action: {
            vm.saveCollection()
            dismiss()
        }, label: {
            Text("Save")
                .foregroundColor(vm.simpleCollectionName.isEmpty ? .gray : .white)
        })
            .disabled(vm.simpleCollectionName.isEmpty)
        )
        .navigationBarBackButtonHidden(true)
        .navigationTitle("New Tea")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        NewCollectionView(vm: CollectionViewModel())
    }
}
