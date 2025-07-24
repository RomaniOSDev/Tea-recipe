//
//  TeaListView.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import SwiftUI

struct TeaListView: View {
    init(){
        
        let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.backgroundColor = .darkBlue
                navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                
                UINavigationBar.appearance().standardAppearance = navBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
                UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    @StateObject var vm = TeaListViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Color.mainBack.ignoresSafeArea()
                VStack(spacing: 20){
                    if vm.teas.isEmpty {
                        VStack {
                            Image(systemName: "cup.and.saucer.fill")
                                .resizable()
                                .frame(width: 90, height: 64)
                                .foregroundStyle(.pink)
                            Text("Tea list is empty")
                                .font(.headline)
                                .foregroundColor(.gray)
                            NavigationLink(destination: {
                                NewTeaVew(vm: vm)
                            }, label: {
                                HStack {
                                    Image(systemName: "plus")
                                    Text("New tea")
                                }
                                .foregroundStyle(.black)
                                .padding(5)
                                .background {
                                    Color.pink.cornerRadius(8)
                                }
                            })
                        }
                        .padding()
                        .frame(maxWidth: 350, maxHeight: 200)
                        
                        .background {
                            Color.white.cornerRadius(20)
                                .opacity(0.1)
                        }
                    }else {
                        ScrollView {
                            ForEach(vm.teas) { tea in
                                CellForTeaView(tea: tea) {
                                    vm.addFavorite(tea)
                                } tapDelete: {
                                    vm.deleteTea(tea)
                                }

                            }
                        }
                    }
                    
                }
                .padding()
            }
            
            .navigationTitle("Tea List")
            .navigationBarItems(trailing: NavigationLink(destination: {
                NewTeaVew(vm: vm)
            }, label: {
                HStack {
                    Image(systemName: "plus")
                    Text("New tea")
                }
                .foregroundStyle(.black)
                .padding(5)
                .background {
                    Color.pink.cornerRadius(8)
                }
            }))
        }
    }
}

#Preview {
    TeaListView()
}
