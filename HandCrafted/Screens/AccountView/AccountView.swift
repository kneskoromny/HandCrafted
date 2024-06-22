import SwiftUI

struct AccountView: View {
    
    enum FormTextField {
        case firstName, lastName, email
    }
    
    @StateObject var viewModel = AccountViewModel()
    @FocusState private var focusedTextField: FormTextField?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Обо мне")) {
                    TextField(
                        "Имя",
                        text: $viewModel.user.firstName
                    )
                        .focused(
                            $focusedTextField,
                            equals: .firstName
                        )
                        .onSubmit {
                            focusedTextField = .lastName
                        }
                        .submitLabel(.next)
                    
                    TextField(
                        "Фамилия",
                        text: $viewModel.user.lastName
                    )
                        .focused(
                            $focusedTextField,
                            equals: .lastName
                        )
                        .onSubmit {
                            focusedTextField = .email
                        }
                        .submitLabel(.next)
                    
                    TextField(
                        "Email",
                        text: $viewModel.user.email
                    )
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .focused(
                            $focusedTextField,
                            equals: .email
                        )
                        .onSubmit {
                            focusedTextField = nil
                        }
                        .submitLabel(.continue)
                    
                    DatePicker(
                        "Дата рождения",
                        selection: $viewModel.user.birthday,
                        displayedComponents: .date
                    )
                    Button(action: {
                        viewModel.saveChanges()
                    },
                           label: {
                        Text("Сохранить изменения")
                    })
                }
            }
            .navigationTitle("🧟‍♀️ Аккаунт")
            .toolbar{
                ToolbarItemGroup(
                    placement: .keyboard
                ) {
                    Button("Отмена") {
                        focusedTextField = nil
                    }
                }
            }
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
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

