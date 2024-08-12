import SwiftUI

struct AccountView: View {
    
    // MARK: - Const
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 24,
            leading: 8,
            bottom: 0,
            trailing: 8
        )
        static let buttonInsets = EdgeInsets(
            top: 0,
            leading: 8,
            bottom: 0,
            trailing: 8
        )
    }
    
    // MARK: - State
    
    @StateObject var viewModel = ProfileViewModel()
    @EnvironmentObject var router: AccountRouter
    
    // MARK: - Body
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    HStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.badge.questionmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.green)
                            .frame(width: 100, height: 100)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("User Name")
                                .font(Constant.AppFont.primary)
                                .tint(.black)
                                .multilineTextAlignment(.leading)
                            Text("user_email@mail.com")
                                .font(Constant.AppFont.secondary)
                                .tint(.gray)
                            
                        }
                    }
                    Button {
                        router.navigate(to: .orders)
                    } label: {
                        ArrowRightButton(
                            title: "My orders",
                            subtitle: "You have no current orders",
                            font: Constant.AppFont.secondary,
                            isSpacer: true
                        )
                    }
                    .frame(height: 44)
                    .padding(Const.buttonInsets)
                    Divider()
                    Button {
                        router.navigate(to: .favorites)
                    } label: {
                        ArrowRightButton(
                            title: "My favorites",
                            subtitle: "2 favorites goods are waiting...",
                            font: Constant.AppFont.secondary,
                            isSpacer: true
                        )
                    }
                    .frame(height: 44)
                    .padding(Const.buttonInsets)
                    Divider()
                    Button {
                        router.navigate(to: .paymentMethods)
                    } label: {
                        ArrowRightButton(
                            title: "Payment methods",
                            subtitle: "VISA **34",
                            font: Constant.AppFont.secondary,
                            isSpacer: true
                        )
                    }
                    .frame(height: 44)
                    .padding(Const.buttonInsets)
                    Divider()
                    Button {
                        router.navigate(to: .shippingAddresses)
                    } label: {
                        ArrowRightButton(
                            title: "Shipping addresses",
                            subtitle: "1 address",
                            font: Constant.AppFont.secondary,
                            isSpacer: true
                        )
                    }
                    .frame(height: 44)
                    .padding(Const.buttonInsets)
                    Divider()
                    Button {
                        router.navigate(to: .settings)
                    } label: {
                        ArrowRightButton(
                            title: "Settings",
                            subtitle: "Notifications, password etc.",
                            font: Constant.AppFont.secondary,
                            isSpacer: true
                        )
                    }
                    .frame(height: 44)
                    .padding(Const.buttonInsets)
                    Spacer()
                }
                .padding(Const.viewInsets)
                .navigationTitle("My profile")
            }
        }
    }
    
}

#Preview {
    AccountView()
}
