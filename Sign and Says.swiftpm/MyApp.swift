import SwiftUI

@main

struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

//struct MyApp: App {
//    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
//
//    var body: some Scene {
//        WindowGroup {
//            ZStack {
//                if hasCompletedOnboarding {
//                    ContentView()
//                        .transition(.opacity)
//                } else {
//                    Onboarding(hasCompletedOnboarding: $hasCompletedOnboarding)
//                        .transition(.opacity)
//                }
//            }
//            .animation(.easeInOut(duration: 0.3), value: hasCompletedOnboarding)
//        }
//    }
//}
