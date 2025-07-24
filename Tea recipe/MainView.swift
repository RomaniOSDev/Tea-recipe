import SwiftUI

struct MainView: View {
    
    init(){
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .black
        appearance.stackedLayoutAppearance.selected.iconColor = .systemPink
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemPink]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
       
    }
    var body: some View {
        TabView {
            TeaListView()
                .tabItem {
                    Label("Tea List", systemImage: "cup.and.saucer.fill")
                }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
            CollectionView()
                .tabItem {
                    Label("Collection", systemImage: "tray.full")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}





#Preview {
    MainView()
}
