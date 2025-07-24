 import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboardingShown") var onboard: Bool?
    @State private var showMain: Bool = false
    @State private var page = 0
    let images: [ImageResource] = [.onBoard1, .onBoard2, .onBoard3]
    let texts = [
        "Organize your tea world.",
        "Save your favorites.",
        "Create tea collections."
    ]
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.mainBack.ignoresSafeArea()
            Image(images[page])
                .resizable()
                .scaledToFit()
                .foregroundColor(.green)
                .padding()
            VStack(alignment: .leading) {
                Text(texts[page])
                    .foregroundStyle(.gray)
                    .font(.system(size: 32))
                    .minimumScaleFactor(0.35)
                    .padding()
                
                HStack(){
                    Spacer()
                    HStack{
                        Text("\(page + 1) / \(images.count)")
                        
                        Button(action: {
                            if page < images.count - 1 {
                                page += 1
                            } else {
                                onboard = false
                                showMain = true
                            }
                        }) {
                            Text("Next")
                                .font(.headline)
                        }
                        
                    }
                    
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .background {
                Color.mainBack.edgesIgnoringSafeArea(.all)
            }
        }
        .fullScreenCover(isPresented: $showMain, content: {
            MainView()
        })
        .animation(.easeInOut, value: page)
    }
} 

#Preview {
    OnboardingView()
}
