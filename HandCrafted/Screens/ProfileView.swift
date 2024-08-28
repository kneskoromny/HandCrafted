import SwiftUI
import SwiftData

struct ProfileView: View {
    
    // MARK: - Const
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 24,
            leading: 8,
            bottom: 0,
            trailing: 8
        )
        static let cellInsets = EdgeInsets(
            top: 0,
            leading: 8,
            bottom: 0,
            trailing: 8
        )
        static let buttonInsets = EdgeInsets(
            top: 8,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
    }
    
    // MARK: - State
    
    @EnvironmentObject var viewModel: ProfileViewModel
    @EnvironmentObject var router: AccountRouter
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        HStack(spacing: 16) {
                            if let urlString = viewModel.user.avatarUrl,
                               let url = URL(string: urlString) {
                                // TODO: how to cache image?
                                AsyncImage(url: url,
                                           content: { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(50)
                                },
                                           placeholder: {
                                    ZStack(alignment: .center) {
                                        Circle()
                                        Text("😍")
                                            .font(.largeTitle)
                                    }
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(50)
                                })
                            } else {
                                ZStack(alignment: .center) {
                                    Circle()
                                    Text("😇")
                                        .font(.largeTitle)
                                }
                                .frame(width: 100, height: 100)
                                .cornerRadius(50)
                            }
                            VStack(alignment: .leading, spacing: 8) {
                                Text(viewModel.user.name ?? "User without name :(")
                                    .font(Constant.AppFont.primary)
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.leading)
                                Text(viewModel.user.email ?? "")
                                    .font(Constant.AppFont.secondary)
                                    .foregroundStyle(.gray)
                                
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
                        .padding(Const.cellInsets)
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
                        .padding(Const.cellInsets)
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
                        .padding(Const.cellInsets)
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
                        .padding(Const.cellInsets)
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
                        .padding(Const.cellInsets)
                        Button {
                            viewModel.logoutUser()
                        } label: {
                            PrimaryButton(
                                title: "Logout",
                                foregroundColor: .white,
                                backgroundColor: .red
                            )
                        }
                        .padding(Const.buttonInsets)
                        Spacer()
                    }
                    .padding(Const.viewInsets)
                    .navigationTitle("My profile")
                }
            }
        }
        .onAppear {
            viewModel.getUser()
        }
    }
    
}

#Preview {
    ProfileView()
}
