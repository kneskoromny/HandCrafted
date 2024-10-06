import SwiftUI

struct BasketView: View {
    
    @EnvironmentObject var basVm: BasketViewModel
    
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
                        .alert(
                            "Удалить?",
                            isPresented: $basVm.isRemoveItemAlert) {
                                Button("Отмена", role: .cancel) {}
                                Button("Удалить") {
                                    basVm.removeOrderItem()
                                    basVm.calculateTotalPrice()
                                }
                            } message: {
                                Text("Вы точно хотите удалить товар из Корзины?")
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
                                        basVm.isOrderAlert = true
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
                            .alert(
                                "Почти готово!",
                                isPresented: $basVm.isOrderAlert) {
                                    Button("Отмена", role: .cancel) {}
                                    Button("Подтверждаю") {
                                        basVm.sendOrder()
                                    }
                                } message: {
                                    Text("""
                                Вы подтверждаете заказ
                                на общую сумму \(basVm.totalPrice) ₽?
                                """)
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
    }
}

#Preview {
    BasketView()
        .environmentObject(BasketViewModel())
}
