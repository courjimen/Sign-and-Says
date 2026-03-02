import SwiftUI

@main
struct MyApp: App {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                ContentView()
            } else {
                Onboarding(hasCompletedOnboarding: $hasCompletedOnboarding)
            }
        }
    }
}

