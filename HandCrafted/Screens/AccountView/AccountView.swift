import SwiftUI

struct AccountView: View {
    
    @StateObject var viewModel = AccountViewModel()
    
    var body: some View {
        NavigationView {
            switch viewModel.accountState {
            case .login:
                LoginView(viewModel: viewModel)
            case .auth:
                AuthView()
            case .register:
                RegisterView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.retrieveUser()
        }
    }
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
