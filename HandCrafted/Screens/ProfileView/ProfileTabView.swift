import SwiftUI
import SwiftData

struct ProfileTabView: View {
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    @ObservedObject var registerRouter = RegisterRouter()
    @ObservedObject var accountRouter = AccountRouter()
    
    var body: some View {
        switch profileViewModel.accountState {
        case .auth:
            NavigationStack(path: $accountRouter.navPath) {
                ProfileView()
                    .navigationDestination(for: AccountRouter.Destination.self) { destination in
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
                        }
                    }
            }
            .environmentObject(accountRouter)
            .environmentObject(profileViewModel)
            
        case .unAuth:
            NavigationStack(path: $registerRouter.navPath) {
                RegisterView()
                    .navigationDestination(for: RegisterRouter.Destination.self) { destination in
                        switch destination {
                        case .signIn:
                            LoginView()
                        case .forgotPassword:
                            ForgotPasswordView()
                        case .recoveryRequested:
                            RecoveryPasswordRequestedView()
                        }
                    }
            }
            .environmentObject(registerRouter)
            .environmentObject(profileViewModel)
        }
    }
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
