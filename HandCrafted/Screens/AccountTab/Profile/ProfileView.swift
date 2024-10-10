import SwiftUI

struct ProfileView: View {
    
    // MARK: - State
    
    @EnvironmentObject var viewModel: ProfileViewModel
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Минуточку...")
            } else {
                List {
                    Section {
                        VStack(spacing: 16) {
                            VStack(spacing: 4) {
                                HStack {
                                    Text("Кирилл Нескоромный")
                                        .font(Constant.AppFont.primary)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.primary)
                                    Spacer()
                                }
                                HStack {
                                    Text("kneskoromny@gmail.com")
                                        .font(Constant.AppFont.secondary)
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                }
                            }
                            Button {
                                router.navigate(to: .settings)
                            } label: {
                                SecondaryButton(
                                    title: "Редактировать данные"
                                )
                            }
                            .padding(
                                EdgeInsets(
                                    top: 0,
                                    leading: 0,
                                    bottom: 4,
                                    trailing: 0
                                )
                            )
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    Section {
                        let subtitle = viewModel.orders.isEmpty
                        ? "У вас пока нет заказов"
                        : "У вас \(viewModel.orders.count) заказов"
                        Button {
                            router.navigate(to: .orders)
                        } label: {
                            ProfileButton(
                                title: "Мои заказы",
                                subtitle: subtitle
                            )
                        }
                        .tint(.primary)
                        Button {
                            router.navigate(to: .shippingAddresses)
                        } label: {
                            ProfileButton(
                                title: "Адреса доставки",
                                subtitle: "У вас нет сохраненных адресов доставки"
                            )
                        }
                        .tint(.primary)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    Section {
                        Button {
                            viewModel.logoutUser()
                        } label: {
                            PrimaryButton(
                                title: "Выйти",
                                foregroundColor: .white,
                                backgroundColor: .red
                            )
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
                .listStyle(.insetGrouped)
                .scrollIndicators(.hidden)
                .listRowSpacing(16)
                .contentMargins(.top, 24)
            }
        }
        .navigationTitle("Мой профиль")
        .onAppear {
            viewModel.getUserInfo()
        }
    }
    
}

#Preview {
    ProfileView()
        .environmentObject(ProfileViewModel())
        .environmentObject(AppRouter())
}

struct ProfileButton: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
    }
    
    var title: String
    var subtitle: String?
    
    var body: some View {
        HStack {
            VStack(spacing: 8) {
                HStack {
                    Text(title)
                        .font(Constant.AppFont.secondary)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                    Spacer()
                }
                if let subtitle {
                    HStack {
                        Text(subtitle)
                            .font(Constant.AppFont.secondary)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                }
            }
            Image(uiImage: UIImage(named: "chevronRight") ?? UIImage())
        }
        .padding(Const.viewInsets)
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(10)
        .clipped()
    }
}
