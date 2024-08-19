import SwiftUI

struct SettingsView: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 24,
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
    
    @StateObject var viewModel = ProfileViewModel()
    @EnvironmentObject var router: AccountRouter
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Personal information")
                    .font(Constant.AppFont.secondary)
                PrimaryTextField(
                    placeholder: "Name",
                    value: $viewModel.user.firstName
                )
                PrimaryTextField(
                    placeholder: "Date of birth",
                    value: $viewModel.user.birthday
                )
                HStack {
                    Text("E-mail")
                        .font(Constant.AppFont.secondary)
                    Spacer()
                    Button {
                        print(#function, "mytest - Change email button tapped")
                    } label: {
                        Text("Change")
                            .font(Constant.AppFont.secondary)
                            .tint(.gray)
                    }
                }
                PrimaryTextField(
                    placeholder: "E-mail",
                    value: $viewModel.user.email
                )
                HStack {
                    Text("Password")
                        .font(Constant.AppFont.secondary)
                    Spacer()
                    Button {
                        print(#function, "mytest - Change password button tapped")
                    } label: {
                        Text("Change")
                            .font(Constant.AppFont.secondary)
                            .tint(.gray)
                    }
                }
                PrimaryTextField(
                    placeholder: "Password",
                    value: $viewModel.user.password
                )
                Text("Notifications")
                    .font(Constant.AppFont.secondary)
                HStack {
                    Text("Sales")
                        .font(Constant.AppFont.secondary)
                    Spacer()
                    Toggle("", isOn: $viewModel.user.isSalesSubOn)
                }
                HStack {
                    Text("New arrivals")
                        .font(Constant.AppFont.secondary)
                    Spacer()
                    Toggle("", isOn: $viewModel.user.isNewArrivalsSubOn)
                }
                Button {
                   print(#function, "mytest - settings saved")
                } label: {
                    PrimaryButton(
                        title: "Save",
                        foregroundColor: .white,
                        backgroundColor: .red
                    )
                }
                .padding(Const.buttonsInsets)
            }
            .navigationTitle("Settings")
            .padding(Const.viewInsets)
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
    SettingsView()
}
