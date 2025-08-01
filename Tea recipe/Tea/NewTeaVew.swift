//
//  NewTeaVew.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import SwiftUI

struct NewTeaVew: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: TeaListViewModel
    @FocusState var isFocused: Bool
    var body: some View {
        ZStack {
            Color.mainBack.ignoresSafeArea()
            ScrollView(.vertical) {
                VStack(spacing: 20){
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color(uiColor: vm.simplrColor.color))
                        HStack{
                            Image(systemName: "cup.and.saucer.fill")
                                .foregroundStyle(.black)
                            Text(vm.simpleName)
                            Spacer()
                        }.padding()
                    }
                    .frame(height: 60)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(ColorTea.allCases, id: \.self) { color in
                                Button {
                                    vm.simplrColor = color
                                } label: {
                                    VStack {
                                        ZStack {
                                            
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(color.color))
                                                .frame(width: 46, height: 46)
                                            
                                    
                                            if vm.simplrColor == color {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 14, weight: .bold))
                                            }
                                        }
                                        Text(color.rawValue)
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                        }
                    }
                    CustonTextField(title: "Tea name", placeholder: "e.g. Jasmine Green, Earl Grey, Matcha", text: $vm.simpleName)
                        .focused($isFocused)
                    
                    HStack{
                        CustonTextField(title: "Brewing Temperature", placeholder: "0°C", text: $vm.simpleBrewingTemp)
                            .focused($isFocused)
                            .keyboardType(.numberPad)
                        CustonTextField(title: "Brewing Time", placeholder: "0 min.", text: $vm.simplrBrewingTime)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                    }
                    CustonTextField(title: "Brewing Notes", placeholder: "e.g. Use filtered water, steep twice, stir gently", text: $vm.simpleNote)
                        .focused($isFocused)
                    CustonTextField(title: "Best Paired With", placeholder: "e.g. Lemon cake, dark chocolate, light snacks", text: $vm.simpleBestPaired)
                        .focused($isFocused)
                        
                    
                }.padding()
            }
        }
        .onTapGesture {
            isFocused = false
        }
        .navigationBarItems(leading: Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(.gray)
        }))
        .navigationBarItems(trailing: Button(action: {
            vm.addTea()
            dismiss()
        }, label: {
            Text("Save")
                .foregroundColor(vm.simpleName.isEmpty ? .gray : .white)
        })
            .disabled(vm.simpleName.isEmpty)
        )
        .navigationBarBackButtonHidden(true)
        .navigationTitle("New Tea")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NewTeaVew( vm: TeaListViewModel())
}
