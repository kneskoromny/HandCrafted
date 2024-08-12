import SwiftUI

struct RecoveryPasswordRequestedView: View {
    
    // MARK: - Const
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
        static let textInsets = EdgeInsets(
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
    
    @EnvironmentObject var router: RegisterRouter
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Text("We have sent an email to the specified address with instructions on password recovery..")
                .font(.title3)
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
                .padding(Const.textInsets)
            
            Button {
                router.navigateToRoot()
            } label: {
                PrimaryButton(
                    title: "To Sign Up",
                    foregroundColor: .white,
                    backgroundColor: .green
                )
            }
            .padding(Const.buttonsInsets)
            Spacer()
        }
        .padding(Const.viewInsets)
        .navigationTitle("Recovery requested")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.navigateToRoot()
                } label: {
                    Label("Back", systemImage: "arrow.left")
                }
                .tint(.red)
            }
        }
    }
}

#Preview {
    RecoveryPasswordRequestedView()
}
