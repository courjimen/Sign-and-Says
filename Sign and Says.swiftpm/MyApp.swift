import SwiftUI

@main

struct MyApp: App {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            Group {
                if hasCompletedOnboarding {
                    ContentView()
                        .transition(.opacity.combined(with: .scale))
                } else {
                    Onboarding(hasCompletedOnboarding: $hasCompletedOnboarding)
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.5), value: hasCompletedOnboarding)
        }
    }
}
