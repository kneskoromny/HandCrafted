import SwiftUI

struct LoginView: View {
    
    // MARK: - State
    
    @EnvironmentObject var viewModel: ProfileViewModel
    @EnvironmentObject var router: AppRouter
    
    // MARK: - Body
    
    var body: some View {
        List {
            Section {
                PrimaryTextField(
                    placeholder: "E-mail",
                    value: $viewModel.loginData.email
                )
                .modifier(EmailTextFieldModifier())
                PrimaryTextField(
                    placeholder: "Пароль",
                    value: $viewModel.loginData.password
                )
                .modifier(PasswordTextFieldModifier())
            }
            .listRowInsets(EdgeInsets())
            Section {
                Button {
                    viewModel.loginUser()
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
        .navigationTitle("Вход")
        .navigationBarBackButtonHidden()
        .listStyle(.insetGrouped)
        .scrollIndicators(.hidden)
        .listRowSpacing(12)
        .listSectionSpacing(24)
        .contentMargins(.top, 24)
    }
    
}

#Preview {
    LoginView()
        .environmentObject(ProfileViewModel())
        .environmentObject(AppRouter())
}
