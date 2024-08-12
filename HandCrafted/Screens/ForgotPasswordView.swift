import SwiftUI

struct ForgotPasswordView: View {
    
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
            top: 24,
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
                    Text("Please, enter your email address. You will receive a link to create a new password via email.")
                        .font(.title3)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                    PrimaryTextField(
                        placeholder: "E-mail",
                        value: $viewModel.user.email
                    )
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                }
                .padding(Const.textFieldsInsets)
                Button {
                    // TODO: Network
                    viewModel.sendPasswordReset {
                        self.router.navigate(to: .recoveryRequested)
                    }
                } label: {
                    PrimaryButton(
                        title: "Send",
                        foregroundColor: .white,
                        backgroundColor: .green
                    )
                }
                .padding(Const.buttonsInsets)
                Spacer()
            }
            .padding(Const.viewInsets)
            .navigationTitle("Forgot password")
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
    ForgotPasswordView()
}
