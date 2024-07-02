import SwiftUI

struct LoginView: View {
    
    private enum Const {
        static let registerButtonPadding =  EdgeInsets(
            top: -16,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        static let viewPadding = EdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
    }
    
    @StateObject var viewModel = AccountViewModel()
    @State var isRegPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Введите данные для входа в аккаунт")
                .font(.title3)
                .foregroundStyle(.secondary)
                .padding(.vertical)
            LoginTextField(
                placeholder: "E-mail",
                value: $viewModel.user.email
            )
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            LoginTextField(
                placeholder: "Пароль",
                value: $viewModel.user.password
            )
            .textContentType(.password)
            .keyboardType(.asciiCapable)
            Button(
                action: {
                    print(#function, "mytest - LogIn did tapped")
                }, label: {
                    HCButton(
                        title: "Войти",
                        foregroundColor: .white,
                        backgroundColor: .green
                    )
                })
            Button(
                action: {
                    viewModel.accountState = .register
                }, label: {
                    HCButton(
                        title: "Зарегистрироваться",
                        foregroundColor: .secondary,
                        backgroundColor: Color(UIColor.systemBackground)
                    )
                })
            .padding(Const.registerButtonPadding)
            Spacer()
        }
        .padding(Const.viewPadding)
        .navigationTitle("🤗 Добро пожаловать")
//        .sheet(isPresented: $isRegPresented,
//               content: {
//            RegisterView(viewModel: viewModel)
//        })
        
    }
}

#Preview {
    LoginView()
}

struct LoginTextField: View {
    
    var placeholder: LocalizedStringKey
    @Binding var value: String
    
    var body: some View {
        TextField(
            placeholder,
            text: $value
        )
        .textFieldStyle(.plain)
        .font(.title2)
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
    }
    
}
