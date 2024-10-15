import SwiftUI

struct RegisterView: View {
    
    // MARK: - Const
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 48,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
        static let buttonsInsets = EdgeInsets(
            top: 8,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
    }
    
    // MARK: - State
    
    @EnvironmentObject var viewModel: ProfileViewModel
    @EnvironmentObject var router: AppRouter
    
    // MARK: - Body
    
    var body: some View {
        List {
            // Имя, Дата рождения, Город, Номер телефона, E-mail
            Section {
                PrimaryTextField(
                    placeholder: "Имя",
                    value: $viewModel.loginData.email
                )
                PrimaryTextField(
                    placeholder: "Дата рождения",
                    value: $viewModel.loginData.email
                )
                PrimaryTextField(
                    placeholder: "Город",
                    value: $viewModel.loginData.email
                )
                PrimaryTextField(
                    placeholder: "Номер телефона",
                    value: $viewModel.loginData.email
                )
                PrimaryTextField(
                    placeholder: "E-mail",
                    value: $viewModel.loginData.email
                )
                .modifier(EmailTextFieldModifier())
            } header: {
                Text("Личные данные")
                    .font(Constant.AppFont.secondary)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
            .listRowInsets(EdgeInsets())
            // Пароль, Подтверждение пароля, Вью с правилами пароля
            Section {
                PrimaryTextField(
                    placeholder: "Пароль",
                    value: $viewModel.loginData.password
                )
                .modifier(PasswordTextFieldModifier())
                PrimaryTextField(
                    placeholder: "Подтверждение пароля",
                    value: $viewModel.loginData.password
                )
                .modifier(PasswordTextFieldModifier())
            } header: {
                Text("Пароль")
                    .font(Constant.AppFont.secondary)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
            .listRowInsets(EdgeInsets())
            // Кнопка
            Section {
                Button {
                    viewModel.registerUser()
                } label: {
                    PrimaryButton(title: "Регистрация")
                }
            }
            .listRowInsets(EdgeInsets())
        }
        .navigationTitle("Регистрация")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.navigateBack()
                } label: {
                    Label("Back", systemImage: "arrow.left")
                }
                .tint(.red)
            }
        }
        .listStyle(.insetGrouped)
        .scrollIndicators(.hidden)
        .listRowSpacing(12)
        .listSectionSpacing(24)
        .contentMargins(.top, 16)
    }
}

#Preview {
    RegisterView()
        .environmentObject(ProfileViewModel())
        .environmentObject(AppRouter())
}
