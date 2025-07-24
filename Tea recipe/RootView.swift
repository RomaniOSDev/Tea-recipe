import SwiftUI

struct RootView: View {
    @AppStorage("onboardingShown") var onboard: Bool?
    var body: some View {
            if onboard ?? true {
                OnboardingView()
            } else {
                MainView()
            }
    }
} 

#Preview {
    RootView()
}
