import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    
    @ObservedObject var registerRouter = RegisterRouter()
    @ObservedObject var accountRouter = AccountRouter()
    
    var body: some View {
        switch viewModel.accountState {
        case .auth:
            NavigationStack(path: $accountRouter.navPath) {
                AccountView()
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
        case .unAuth:
            NavigationStack(path: $registerRouter.navPath) {
                SignUpView(viewModel: viewModel)
                    .navigationDestination(for: RegisterRouter.Destination.self) { destination in
                        switch destination {
                        case .signIn:
                            SignInView(viewModel: viewModel)
                        case .forgotPassword:
                            ForgotPasswordView(viewModel: viewModel)
                        case .recoveryRequested:
                            RecoveryPasswordRequestedView()
                        }
                    }
            }
            .environmentObject(registerRouter)
        }
    }
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
