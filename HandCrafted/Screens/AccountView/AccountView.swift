import SwiftUI

struct AccountView: View {
    
    @StateObject var viewModel = AccountViewModel()
    
    @ObservedObject var registerRouter = RegisterRouter()
    
    var body: some View {
        switch viewModel.accountState {
        case .auth:
            AuthView()
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
