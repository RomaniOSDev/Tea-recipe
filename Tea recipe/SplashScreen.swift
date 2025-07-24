import SwiftUI

struct SplashScreen: View {
    @State private var loading: Bool = false
    var body: some View {
        ZStack{
            Color.mainBack.ignoresSafeArea()
            VStack {
                Spacer()
                Image(.logo)
                    .resizable()
                    .frame(width: 128, height: 128)
                Spacer()
                HStack {
                    ProgressView()
                        .scaleEffect(1.5)
                    Text("Loading...")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        
                }
                .padding(.bottom, 40)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation {
                        loading = true
                    }
                }
            }
            .fullScreenCover(isPresented: $loading) {
                RootView()
            }
        }
    }
}

#Preview {
    SplashScreen()
}
