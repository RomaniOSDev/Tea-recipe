//
//  CollectionView.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import SwiftUI

struct CollectionView: View {
    init(){
        
        let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.backgroundColor = .darkBlue
                navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                
                UINavigationBar.appearance().standardAppearance = navBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
                UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    
    @StateObject var vm = CollectionViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.mainBack.ignoresSafeArea()
                VStack(spacing: 20){
                    if vm.collectionTea.isEmpty {
                        VStack {
                            Image(systemName: "folder.fill")
                                .resizable()
                                .frame(width: 90, height: 64)
                                .foregroundStyle(.pink)
                            Text("You don't have a collection yet")
                                .font(.headline)
                                .foregroundColor(.gray)
                            NavigationLink(destination: {
                                NewCollectionView(vm: vm)
                            }, label: {
                                HStack {
                                    Image(systemName: "plus")
                                    Text("New collection")
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
                            ForEach(vm.collectionTea) { collection in
                                CellForCollectionview(collection: collection) {
                                    vm.presenetCollection.toggle()
                                    vm.simpleCollection = collection
                                } tapToDelete: {
                                    vm.deleteCollection(collection)
                                }
                            }
                        }
                    }
                    
                }
                .padding()
            }
            .sheet(isPresented: $vm.presenetCollection, content: {
                CollectionOpenView(vm: vm)
            })
            .navigationTitle("Collections")
            .navigationBarItems(trailing: NavigationLink(destination: {
                NewCollectionView(vm: vm)
            }, label: {
                HStack {
                    Image(systemName: "plus")
                    Text("New collection")
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
    CollectionView()
}
