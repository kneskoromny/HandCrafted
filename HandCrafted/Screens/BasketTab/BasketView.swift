import SwiftUI

struct BasketView: View {
    
    @EnvironmentObject var basVm: BasketViewModel
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        VStack {
            if basVm.isLoading {
                ProgressView("Минуточку...")
            } else {
                if basVm.orderItems.isEmpty {
                    VStack(spacing: 48) {
                        Image("orderSuccess", bundle: nil)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                        VStack(spacing: 16) {
                            Text("Нет товаров")
                                .font(Constant.AppFont.primary)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                            Text("Добавьте понравившиеся товары из Каталога, чтобы поскорее их заказать ☺️")
                                .font(Constant.AppFont.secondary)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding()
                } else {
                    List {
                        Section {
                            ForEach(basVm.orderItems) { item in
                                Button {} label: {
                                    BasketOrderItemView(
                                        orderItem: item,
                                        height: 125
                                    )
                                }
                                .tint(.primary)
                                .listRowInsets(EdgeInsets())
                            }
                        }
                        if !basVm.orderItems.isEmpty {
                            Section {
                                VStack(spacing: 16) {
                                    HStack {
                                        Text("Общая сумма:")
                                            .font(Constant.AppFont.secondary)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                        Text("\(basVm.totalPrice) ₽")
                                            .font(Constant.AppFont.primary)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.primary)
                                            .padding(.trailing)
                                    }
                                    Button {
                                        basVm.alertType = basVm.isAuthUser 
                                        ? .preOrder(
                                            totalPrice: basVm.totalPrice,
                                            action: {
                                                self.basVm.sendOrder()
                                            })
                                        : .unAuthUser(action: {
                                            router.selectedTab = .account
                                        })
                                        basVm.isAlertPresented = true
                                    } label: {
                                        PrimaryButton(
                                            title: "Заказать",
                                            foregroundColor: Color(uiColor: .systemBackground),
                                            backgroundColor: .red
                                        )
                                    }
                                }
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color.clear)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .scrollIndicators(.hidden)
                    .listRowSpacing(16)
                    .contentMargins(.top, 24)
                }
            }
        }
        .navigationTitle("Корзина")
        .navigationBarBackButtonHidden()
        .alert(isPresented: $basVm.isAlertPresented) {
            return basVm.alertType?.view ?? Alert(title: Text(""))
        }
    }
}

#Preview {
    BasketView()
        .environmentObject(BasketViewModel())
}
