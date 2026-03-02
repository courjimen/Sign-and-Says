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
}

struct Onboarding: View {
    @Binding var hasCompletedOnboarding: Bool
    @State var currentPage = 0
    @State var isAnimating = false
    @State var deliveryOffset = false
    @State var trackingProgress: CGFloat = 0.0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(OnboardingPage.allCases, id: \.rawValue) { page in
                    getPageView(for: page)
                        .tag(page.rawValue)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.spring(), value: currentPage)
            
            HStack(spacing: 12){
                ForEach(0..<OnboardingPage.allCases.count, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color(Color("Lilac")) : Color.gray.opacity(0.5))
                        .frame(width: currentPage == index ? 12 : 8, height: currentPage == index ? 12 : 8)
                        .animation(.spring(), value: currentPage)
                }
            }
            .padding(.bottom, 20)
            
            Button {
                withAnimation(.spring()) {
                    if currentPage < OnboardingPage.allCases.count - 1 {
                        currentPage += 1
                        isAnimating = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            isAnimating = true
                        })
                    } else {
                        hasCompletedOnboarding = true                    }
                }
            } label: {
                Text(currentPage < OnboardingPage.allCases.count - 1 ? "Next" : "Get Started")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [
                            Color(Color("DustyOrange")),
                            Color(Color("DustyOrange")).opacity(0.8)
                        ]), startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color("DustyOrange").opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                withAnimation {
                    isAnimating = true
                }
            })
        }
    }
    var pecsImages: some View {
        ZStack {
            Image(.pecs)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .offset(y: isAnimating ? 0 : 20)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimating)
                .zIndex(1)
        }
    }
    var aslImages: some View {
        ZStack {
            Image(.asl)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .offset(y: isAnimating ? 0 : 20)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimating)
                .zIndex(1)
                .padding(.top, -23)
        }
    }
    
    var careCardImages: some View {
        ZStack {
            Image(.shareableCareCard)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .offset(y: isAnimating ? 0 : 20)
                .animation(.spring(dampingFraction: 0.6).delay(0.2), value: isAnimating)
                .zIndex(1)
        }
    }
    
    @ViewBuilder
    func getPageView(for page: OnboardingPage) -> some View {
        VStack(spacing: 30) {
            //MARK: Images
            ZStack {
                switch page {
                case .PECS:
                    pecsImages
                case .ASL:
                    aslImages
                case .careCard:
                    careCardImages
                }
            }
            
            //MARK: Content
            VStack(spacing: 20) {
                Text(page.title)
                    .font(.custom("Lexend-ExtraBold", size: 25))
                    .foregroundColor(Color("Cafe"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimating)
                
                Text(page.description)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.spring(dampingFraction: 0.8).delay(0.3), value: isAnimating)
            }
        }
        .padding(.top, 50)
    }
}

#Preview {
    Onboarding(hasCompletedOnboarding: .constant(false))
}
