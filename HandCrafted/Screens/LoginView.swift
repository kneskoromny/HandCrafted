import SwiftUI

struct LoginView: View {
    
    // MARK: - Const
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
        static let textFieldsInsets = EdgeInsets(
            top: 48,
            leading: 0,
            bottom: 0,
            trailing: 0
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
    @EnvironmentObject var router: RegisterRouter
    
    // MARK: - Body
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else {
            VStack {
                VStack(spacing: 16) {
                    PrimaryTextField(
                        placeholder: "E-mail",
                        value: $viewModel.loginData.email
                    )
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    PrimaryTextField(
                        placeholder: "Password",
                        value: $viewModel.loginData.password
                    )
                    .textContentType(.password)
                    .keyboardType(.asciiCapable)
                }
                .padding(Const.textFieldsInsets)
                
                VStack(spacing: 16)  {
                    Button {
                        router.navigate(to: .forgotPassword)
                    } label: {
                        HStack {
                            Spacer()
                            ArrowRightButton(
                                title: "Forgot your password?",
                                font: .subheadline,
                                isSpacer: false
                            )
                        }
                    }
                    Button {
                        viewModel.loginUser()
                    } label: {
                        PrimaryButton(
                            title: "Sign In",
                            foregroundColor: .white,
                            backgroundColor: .green
                        )
                    }
                }
                .padding(Const.buttonsInsets)
                Spacer()
            }
            .padding(Const.viewInsets)
            .navigationTitle("Sign In")
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
        }
    }
}

#Preview {
    LoginView()
}
