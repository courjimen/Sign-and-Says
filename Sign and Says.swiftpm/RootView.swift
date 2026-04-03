//
//  RootView.swift
//  Sign and Says
//
//  Created by Courey Jimenez on 4/3/26.
//

import SwiftUI

let onboardingKey = "hasCompletedOnboarding"
struct RootView: View {
    @AppStorage(onboardingKey) var hasCompletedOnboarding: Bool = false
    
    var body: some View {
        Group{
            if hasCompletedOnboarding {
                ContentView()
                   // .transition(.opacity)
            } else {
                Onboarding(hasCompletedOnboarding: $hasCompletedOnboarding)
                   // .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.4), value: hasCompletedOnboarding)
    }
}

#Preview {
    RootView()
       .environment(\.colorScheme, .dark)
}
