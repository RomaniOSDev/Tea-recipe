//
//  AddTeaForCollectionView.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import SwiftUI

struct AddTeaForCollectionView: View {
    @StateObject var vm: CollectionViewModel
    var body: some View {
        ZStack {
            Color.mainBack.ignoresSafeArea()
            VStack(spacing: 20){
                HStack{
                    Button {
                        vm.presentTeam.toggle()
                        vm.simpleCollectionTea.removeAll()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                    Text("Add tea")
                        .font(.headline)
                    Spacer()
                    
                    Button {
                        vm.presentTeam.toggle()
                    } label: {
                        Text("Add")
                            .foregroundStyle(vm.simpleCollectionTea.isEmpty ? .gray : .white)
                    }.disabled(vm.simpleCollectionTea.isEmpty)
                }
                .foregroundStyle(.white)
                
                ScrollView{
                    ForEach(vm.teas) { tea in
                        CellForAddTeaview(tea: tea, tapToAdd: {
                            vm.addForSimpleCollection(tea)
                        }, isInclude: vm.checkInSimpleCollection(tea))
                    }
                }
            }.padding()
        }
    }
}

#Preview {
    AddTeaForCollectionView(vm: CollectionViewModel())
}
