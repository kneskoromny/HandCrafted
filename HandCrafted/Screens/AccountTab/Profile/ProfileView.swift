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
    @EnvironmentObject var appRouter: AppRouter
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Минуточку...")
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
                            appRouter.navigate(to: .orders)
                        } label: {
                            let subtitle = viewModel.orders.isEmpty 
                            ? "У вас пока нет заказов"
                            : "У вас \(viewModel.orders.count) заказов"
                            ArrowRightButton(
                                title: "Мои заказы",
                                subtitle: subtitle,
                                font: Constant.AppFont.secondary,
                                isSpacer: true
                            )
                        }
                        .frame(height: 44)
                        .padding(Const.cellInsets)
                        Divider()
                        Button {
                            appRouter.navigate(to: .favorites)
                        } label: {
                            ArrowRightButton(
                                title: "Мои избранные",
                                subtitle: "У вас пока нет избранных товаров",
                                font: Constant.AppFont.secondary,
                                isSpacer: true
                            )
                        }
                        .frame(height: 44)
                        .padding(Const.cellInsets)
                        Divider()
                        Button {
                            appRouter.navigate(to: .paymentMethods)
                        } label: {
                            ArrowRightButton(
                                title: "Способы оплаты",
                                subtitle: "У вас нет сохраненных способов оплаты",
                                font: Constant.AppFont.secondary,
                                isSpacer: true
                            )
                        }
                        .frame(height: 44)
                        .padding(Const.cellInsets)
                        Divider()
                        Button {
                            appRouter.navigate(to: .shippingAddresses)
                        } label: {
                            ArrowRightButton(
                                title: "Адреса доставки",
                                subtitle: "У вас нет сохраненных адресов доставки",
                                font: Constant.AppFont.secondary,
                                isSpacer: true
                            )
                        }
                        .frame(height: 44)
                        .padding(Const.cellInsets)
                        Divider()
                        Button {
                            appRouter.navigate(to: .settings)
                        } label: {
                            ArrowRightButton(
                                title: "Настройки",
                                subtitle: "Почта, пароль и т.д.",
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
                                title: "Выйти",
                                foregroundColor: .white,
                                backgroundColor: .red
                            )
                        }
                        .padding(Const.buttonInsets)
                        Spacer()
                    }
                    .padding(Const.viewInsets)
                    .navigationTitle("Мой профиль")
                }
            }
        }
        .onAppear {
            viewModel.getUserInfo()
        }
    }
    
}

#Preview {
    ProfileView()
}
