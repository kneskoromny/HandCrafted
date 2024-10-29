import SwiftUI

struct LoginView: View {
    
    // MARK: - State
    
    @StateObject var loginVm: LoginViewModel = LoginViewModel()
    @Binding var accountState: AccountState
    @EnvironmentObject var router: AppRouter
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if loginVm.isLoading {
                ProgressView("Минуточку...")
            } else {
                List {
                    Section {
                        PrimaryTextField(
                            inputType: .email,
                            value: $loginVm.loginData.email,
                            error: $loginVm.errorData.email
                        )
                        PrimaryTextField(
                            inputType: .password,
                            value: $loginVm.loginData.password,
                            error: $loginVm.errorData.password
                        )
                    }
                    .listRowInsets(EdgeInsets())
                    Section {
                        Button {
                            loginVm.loginUser() {
                                accountState = .auth
                            }
                        } label: {
                            PrimaryButton(
                                title: "Войти"
                            )
                        }
                        Button {
                            router.navigate(to: .register)
                        } label: {
                            SecondaryButton(
                                title: "Зарегистрироваться"
                            )
                        }
                        .tint(.primary)
                    }
                    .listRowInsets(
                        EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
                    )
                }
                .listStyle(.insetGrouped)
                .scrollIndicators(.hidden)
                .listRowSpacing(12)
                .listSectionSpacing(24)
                .contentMargins(.top, 24)
            }
        }
        .navigationTitle("Вход")
        .navigationBarBackButtonHidden()
        .onAppear {
            accountState = loginVm.getAccountState()
        }
    }
    
}

#Preview {
    LoginView(accountState: .constant(.unAuth))
        .environmentObject(AppRouter())
}
