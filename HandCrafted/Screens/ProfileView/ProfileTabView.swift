import SwiftUI
import SwiftData

struct ProfileTabView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    @EnvironmentObject var appRouter: AppRouter
    
    var body: some View {
        switch profileViewModel.accountState {
        case .auth:
            NavigationStack(path: $appRouter.navPath) {
                ProfileView()
                    .navigationDestination(for: AppDestination.self) { destination in
                        switch destination {
                        case .orders:
                            Text("Orders View")
                        case .favorites:
                            Text("Favorites View")
                        case .shippingAddresses:
                            Text("Shipping Addresses View")
                        case .paymentMethods:
                            Text("Payment Methods View")
                        case .settings:
                            SettingsView()
                        default:
                            Text("Ошибка роутинга 🙀")
                        }
                    }
            }
            .environmentObject(profileViewModel)
            
        case .unAuth:
            NavigationStack(path: $appRouter.navPath) {
                RegisterView()
                    .navigationDestination(for: AppDestination.self) { destination in
                        switch destination {
                        case .signIn:
                            LoginView()
                        case .forgotPassword:
                            ForgotPasswordView()
                        case .recoveryRequested:
                            RecoveryPasswordRequestedView()
                        default:
                            Text("Ошибка роутинга 🙀")
                        }
                    }
            }
            .environmentObject(profileViewModel)
        }
    }
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AppRouter())
    }
}
