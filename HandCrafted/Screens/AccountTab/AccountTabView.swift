import SwiftUI
import SwiftData

struct AccountTabView: View {
    
    @State var accountState: AccountState = .unAuth
    @StateObject var accountVm = AccountViewModel()
    @EnvironmentObject var appRouter: AppRouter
    
    var body: some View {
        VStack {
            switch accountState {
            case .auth:
                NavigationStack(path: $appRouter.navPath) {
                    ProfileView(accountState: $accountState)
                        .navigationDestination(for: AppDestination.self) { destination in
                            switch destination {
                            case .orders:
                                MyOrdersView()
                            case .orderDetail(let order):
                                MyOrderDetailView(order: order)
                            case .favorites:
                                Text("Favorites View")
                            case .shippingAddresses:
                                Text("Shipping Addresses View")
                            case .paymentMethods:
                                Text("Payment Methods View")
                            case .settings:
                                MyDataView()
                            default:
                                Text("Ошибка роутинга 🙀")
                            }
                        }
                }
                
            case .unAuth:
                NavigationStack(path: $appRouter.navPath) {
                    LoginView(accountState: $accountState)
                        .navigationDestination(for: AppDestination.self) { destination in
                            switch destination {
                            case .register:
                                RegisterView(accountState: $accountState)
                            case .forgotPassword:
                                ForgotPasswordView()
                            case .recoveryRequested:
                                RecoveryPasswordRequestedView()
                            default:
                                Text("Ошибка роутинга 🙀")
                            }
                        }
                }
            }
        }
        .onAppear {
            accountState = accountVm.getAccountState()
        }
    }
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(accountState: .constant(.auth))
            .environmentObject(AppRouter())
    }
}
