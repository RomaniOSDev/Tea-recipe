//
//  FavoritesView.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import SwiftUI

struct FavoritesView: View {
    init(){
        
        let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.backgroundColor = .darkBlue
                navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                
                UINavigationBar.appearance().standardAppearance = navBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
                UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    @StateObject var vm = FavoriteViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Color.mainBack.ignoresSafeArea()
                VStack(spacing: 20){
                    if vm.favoriteTeas.isEmpty {
                        VStack {
                            Image(systemName: "bookmark.fill")
                                .resizable()
                                .frame(width: 50, height: 64)
                                .foregroundStyle(.pink)
                            Text("Favorites is empty")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                        }
                        .padding()
                        .frame(maxWidth: 350, maxHeight: 200)
                        
                        .background {
                            Color.white.cornerRadius(20)
                                .opacity(0.1)
                        }
                    }else {
                        ScrollView {
                            ForEach(vm.favoriteTeas) { tea in
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
            .onAppear(perform: {
                vm.fetchFavoriteTeas()
            })
            
            .navigationTitle("Favorites")
            
        }
    }
}

#Preview {
    FavoritesView()
}
