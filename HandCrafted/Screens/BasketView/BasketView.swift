import SwiftUI

struct BasketView: View {
    
    @EnvironmentObject var basVm: BasketViewModel
    
    var body: some View {
        VStack {
            if basVm.isLoading {
                ProgressView("Минуточку...")
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
                                    print(#function, "mytest - order btn tapped")
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
        .navigationTitle("Корзина")
        .navigationBarBackButtonHidden()
        .alert(
            "Удалить?",
            isPresented: $basVm.isAlertPresented) {
                Button("Отмена", role: .cancel) {}
                Button("Удалить") {
                    basVm.removeOrderItem()
                    basVm.calculateTotalPrice()
                }
            } message: {
                Text("Вы точно хотите удалить товар из Корзины?")
            }
    
}
}

#Preview {
    BasketView()
        .environmentObject(BasketViewModel())
}
