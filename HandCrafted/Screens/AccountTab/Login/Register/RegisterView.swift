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
    
    @StateObject private var regVm = RegisterViewModel()
    @Binding var accountState: AccountState
    @EnvironmentObject var router: AppRouter
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if regVm.isLoading {
                ProgressView("Минуточку...")
            } else {
                List {
                    // Имя, Дата рождения, Город, Номер телефона, E-mail
                    Section {
                        PrimaryTextField(
                            inputType: .name,
                            isDisabled: $regVm.isDisabled,
                            value: $regVm.registerData.name,
                            error: $regVm.errorData.name
                        )
                        PrimaryTextField(
                            inputType: .birthDate,
                            isDisabled: $regVm.isDisabled,
                            value: $regVm.registerData.birthDate,
                            error: $regVm.errorData.birthDate
                        )
                        PrimaryTextField(
                            inputType: .city,
                            isDisabled: $regVm.isDisabled,
                            value: $regVm.registerData.city,
                            error: $regVm.errorData.city
                        )
                        PrimaryTextField(
                            inputType: .phone,
                            isDisabled: $regVm.isDisabled,
                            value: $regVm.registerData.phone,
                            error: $regVm.errorData.phone
                        )
                        PrimaryTextField(
                            inputType: .email,
                            isDisabled: $regVm.isDisabled,
                            value: $regVm.registerData.email,
                            error: $regVm.errorData.email
                        )
                    } header: {
                        Text("Личные данные")
                            .font(Constant.AppFont.secondary)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    .listRowInsets(EdgeInsets())
                    
                    // Пароль, Подтверждение пароля
                    Section {
                        SecureTextField(
                            inputType: .password,
                            value: $regVm.registerData.password,
                            comparsionValue: $regVm.registerData.password,
                            error: $regVm.errorData.password
                        )
                        SecureTextField(
                            inputType: .confirm,
                            value: $regVm.registerData.confirm,
                            comparsionValue: $regVm.registerData.password,
                            error: $regVm.errorData.confirm
                        )
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
                            if regVm.isFormReady {
                                regVm.registerUser() {
                                    router.navigateToRoot()
                                }
                            } else {
                                regVm.isAlertPresented = true
                            }
                        } label: {
                            PrimaryButton(title: "Регистрация")
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.insetGrouped)
                .scrollIndicators(.hidden)
                .listSectionSpacing(24)
                .contentMargins(.top, 16)
            }
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
        .alert(
            "Ошибка формы",
            isPresented: $regVm.isAlertPresented) {
                Button("OK") {}
            } message: {
                Text("Чтобы зарегистрироваться заполните все поля или устраните ошибки.")
            }
    }
    
}

#Preview {
    RegisterView(accountState: .constant(.unAuth))
        .environmentObject(AppRouter())
}
