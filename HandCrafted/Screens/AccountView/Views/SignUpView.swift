import SwiftUI

struct SignUpView: View {
    
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
    
    @StateObject var viewModel = AccountViewModel()
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
                .padding(Const.textFieldsInsets)
                
                VStack(spacing: 16)  {
                    Button {
                        router.navigate(to: .signIn)
                    } label: {
                        HStack {
                            Spacer()
                            TextImageButton(
                                title: "Already have an account?",
                                imageName: "arrowRight"
                            )
                        }
                    }
                    Button {
                        // TODO: network
                        print(#function, "mytest - sign up did tapped")
                        viewModel.isLoading = true
                        let deadline: DispatchTime = .now() + 1
                        DispatchQueue.main.asyncAfter(deadline: deadline) {
                            viewModel.isLoading = false
                        }
                        //                    viewModel.accountState = .auth
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
        }
        
    }
}

#Preview {
    SignUpView()
}
