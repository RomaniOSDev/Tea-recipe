//
//  SettingsView.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @State var urlShare = "https://www.apple.com/app-store/"
    @State var isPresentShare: Bool = false
    let manager = CDTeaManager.instance
    @State private var showAlarm: Bool = false
    
    var body: some View {
        ZStack {
            Color.mainBack.ignoresSafeArea()
            VStack{
                Text("Settings")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundColor(.white)
                Button {
                    isPresentShare.toggle()
                } label: {
                    SettingsButtonView(text: "Shate the app")
                }
                
                Button {
                    SKStoreReviewController.requestReview()
                } label: {
                    SettingsButtonView(text: "Rate the app")
                }
                
                Button {
                    if let url = URL(string: "https://www.termsfeed.com/live/51abff24-9396-4c7a-a73f-6f68237dcec0") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    SettingsButtonView(text: "Usage policy")
                }
                
                Button {
                    showAlarm.toggle()
                } label: {
                    SettingsButtonView(text: "Delete all data")
                }
Spacer()
            }
            .alert(isPresented: $showAlarm) {
                Alert(title: Text("Are you sure?"), message: Text("All data will be deleted"), primaryButton: .destructive(Text("Delete")) {
                    self.manager.deleteAllData()
                }, secondaryButton: .cancel())
            }
            .sheet(isPresented: $isPresentShare, content: {
                ShareSheet(items: urlShare )
            })
            .padding()
        }
    }
}


#Preview {
    SettingsView()
}


struct ShareSheet: UIViewControllerRepresentable{
    var items: String
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let av = UIActivityViewController(activityItems: [items], applicationActivities: nil)
        return av
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct SettingsButtonView: View {
    let text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.black)
                .frame(height: 40)
            Text(text)
                .foregroundStyle(.white)
                .font(.headline)
                .padding()
        }
    }
}
