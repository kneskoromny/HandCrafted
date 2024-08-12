import SwiftUI

struct SignUpView: View {
    
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
    
    @StateObject var viewModel = ProfileViewModel()
    @EnvironmentObject var router: RegisterRouter
    
    // MARK: - Body
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else {
            VStack {
                VStack(spacing: 16) {
                    PrimaryTextField(
                        placeholder: "Name",
                        value: $viewModel.user.firstName
                    )
                    PrimaryTextField(
                        placeholder: "E-mail",
                        value: $viewModel.user.email
                    )
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    PrimaryTextField(
                        placeholder: "Password",
                        value: $viewModel.user.password
                    )
                    .textContentType(.newPassword)
                    .keyboardType(.asciiCapable)
                }
                
                VStack(spacing: 16)  {
                    Button {
                        router.navigate(to: .signIn)
                    } label: {
                        HStack {
                            Spacer()
                            ArrowRightButton(
                                title: "Already have an account?",
                                font: .subheadline,
                                isSpacer: false
                            )
                        }
                    }
                    Button {
                        viewModel.createUser()
                    } label: {
                        PrimaryButton(
                            title: "Sign Up",
                            foregroundColor: .white,
                            backgroundColor: .green
                        )
                    }
                }
                .padding(Const.buttonsInsets)
                Spacer()
            }
            .padding(Const.viewInsets)
            .navigationTitle("Sign Up")
            .alert(item: $viewModel.alertItem) { alert in
                Alert(
                    title: alert.title,
                    message: alert.message,
                    dismissButton: alert.dismissButton
                )
            }
        }
        
    }
}

#Preview {
    SignUpView()
}
