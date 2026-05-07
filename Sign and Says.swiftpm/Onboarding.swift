import SwiftUI

enum OnboardingPage: Int, CaseIterable {
    case PECS
    case ASL
    case careCard
    
    var title: String {
        switch self {
        case .PECS:
            return "An Easier Way to Communicate"
        case .ASL:
            return "Real-Life Practice"
        case .careCard:
            return "Share Important Details"
        }
    }
    
    var description: String {
        switch self {
        case .PECS:
            return "Learn how to use Picture Exchange Communication Systems (PECS) to help your loved one communicate their needs and feelings."
        case .ASL:
            return "Explore new ways to communicate through sign language. Practice makes perfect!"
        case .careCard:
            return "Share the most important information about your loved one with people they trust."
        }
    }
    var caption: String {
        switch self {
        case .PECS:
            return "Traditional PEC Functionality"
        case .ASL:
            return "Character Inspiration: Baby Sign Language"
        case .careCard:
            return "Easily Accessible PDF Format"
        }
    }
}

struct Onboarding: View {
    @Binding var hasCompletedOnboarding: Bool
    @State var currentPage = 0
    @State var isAnimating = false
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var isLandscape: Bool {
        verticalSizeClass == .compact
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentPage) {
                ForEach(OnboardingPage.allCases, id: \.rawValue) { page in
                    getPageView(for: page)
                        .tag(page.rawValue)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            VStack(spacing: 20) {
                HStack(spacing: 12){
                    ForEach(0..<OnboardingPage.allCases.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? Color("Lilac") : Color.gray.opacity(0.5))
                            .frame(width: currentPage == index ? 12 : 8, height: currentPage == index ? 12 : 8)
                    }
                }
                
                Button {
                    if currentPage < OnboardingPage.allCases.count - 1 {
                        withAnimation(.spring()) {
                            currentPage += 1
                            isAnimating = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isAnimating = true
                        }
                    } else {
                        hasCompletedOnboarding = true
                    }
                } label: {
                    Text(currentPage < OnboardingPage.allCases.count - 1 ? "Next" : "Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: isLandscape ? 300 : .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [
                                Color("DustyOrange"),
                                Color("DustyOrange").opacity(0.8)
                            ]), startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(.horizontal, 30)
            }
            .padding(.bottom, isLandscape ? 10 : 30)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation { isAnimating = true }
            }
        }
    }

    @ViewBuilder
    func getPageView(for page: OnboardingPage) -> some View {
        let layout = isLandscape
            ? AnyLayout(HStackLayout(spacing: 20))
            : AnyLayout(VStackLayout(spacing: 30))

        layout {
            Group {
                switch page {
                case .PECS: pecsImages
                case .ASL: aslImages
                case .careCard: careCardImages
                }
            }
            .frame(maxWidth: isLandscape ? 250 : .infinity)

            VStack(spacing: isLandscape ? 10 : 20) {
                Text(page.title)
                    .font(.custom("Lexend-ExtraBold", size: isLandscape ? 22 : 25))
                    .foregroundColor(Color("Cafe"))
                    .multilineTextAlignment(.center)

                Text(page.description)
                    .font(.system(isLandscape ? .body : .title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Grey"))
                    .multilineTextAlignment(.center)
                
                Text(page.caption)
                    .font(.system(.caption, design: .default))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Cafe"))
            }
            .padding(.horizontal, 32)
            .frame(maxWidth: isLandscape ? 350 : .infinity)
            .opacity(isAnimating ? 1 : 0)
            .offset(y: isAnimating ? 0 : 20)
            .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimating)
        }
        .padding(.horizontal, isLandscape ? 40 : 0)
        .padding(.top, isLandscape ? 20 : 50)
    }

    var pecsImages: some View {
        Image(.pecs)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: isLandscape ? 180 : 300)
            .offset(y: isAnimating ? 0 : 20)
            .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimating)
    }

    var aslImages: some View {
        Image(.asl)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: isLandscape ? 180 : 300)
            .offset(y: isAnimating ? 0 : 20)
            .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimating)
    }

    var careCardImages: some View {
        Image(.shareableCareCard)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: isLandscape ? 180 : 300)
            .offset(y: isAnimating ? 0 : 20)
            .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimating)
    }
}

#Preview  {
        Onboarding(hasCompletedOnboarding: .constant(false))
         //   .environment(\.colorScheme, .dark)
    }
    
