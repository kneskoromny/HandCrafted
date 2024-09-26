import SwiftUI

struct ProductDetailView: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
    }
    
    @EnvironmentObject var catalogViewModel: CatalogViewModel
    @EnvironmentObject var router: CatalogRouter
    
    var product: Product
    
    var screenWidth: CGFloat = {
        return UIScreen.main.bounds.width
    }()
    
    var body: some View {
        VStack {
            if catalogViewModel.isLoading {
                ProgressView("Минуточку...")
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 24) {
                        if let imageUrls = product.imageUrls {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 0) {
                                    ForEach(imageUrls.indices, id: \.self) { index in
                                        if let url = URL(string: imageUrls[index]) {
                                            AsyncImage(url: url,
                                                       content: { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                            },
                                                       placeholder: {
                                                ProgressView()
                                            })
                                            .frame(width: screenWidth - 16, height: screenWidth * 1.15)
                                            .clipped()
                                        } else {
                                            NoImageView(width: screenWidth - 16, height: screenWidth * 1.15)
                                        }
                                    }
                                }
                            }
                        } else {
                            NoImageView(width: screenWidth - 16, height: screenWidth * 1.15)
                        }
                        VStack(spacing: 32) {
                            HStack(spacing: 16) {
                                VStack(spacing: 8) {
                                    HStack {
                                        Text("Размер")
                                        Spacer()
                                    }
                                    Button {
                                        catalogViewModel.sheetSelectType = .size
                                        catalogViewModel.isSheetPresented = true
                                    } label: {
                                        SelectableButton(
                                            title: catalogViewModel.selectedProduct == nil ? "Выберите" : catalogViewModel.selectedProduct?.selectedSize?.name,
                                            font: Constant.AppFont.secondary,
                                            color: catalogViewModel.selectedProduct == nil ? .secondary : .primary,
                                            height: 44,
                                            isSelectable: true
                                        )
                                    }
                                    .disabled(product.sizes.count < 2)
                                }
                                VStack(spacing: 8) {
                                    HStack {
                                        Text("Цвет")
                                        Spacer()
                                    }
                                    Button {
                                        catalogViewModel.sheetSelectType = .color
                                        catalogViewModel.isSheetPresented = true
                                    } label: {
                                        SelectableButton(
                                            title: product.color.name,
                                            font: Constant.AppFont.secondary,
                                            color: .primary,
                                            height: 44,
                                            isSelectable: product.color.list.count > 1
                                        )
                                    }
                                    .disabled(product.color.list.count < 2)
                                }
                            }
                            HStack {
                                VStack(spacing: 8) {
                                    HStack {
                                        Text(product.name)
                                            .font(Constant.AppFont.primary)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                        Spacer()
                                        
                                    }
                                    HStack {
                                        Text(product.composition)
                                            .font(Constant.AppFont.secondary)
                                            .foregroundStyle(.gray)
                                        Spacer()
                                    }
                                }
                                Spacer()
                                VStack {
                                    HStack {
                                        Spacer()
                                        if let selectedProduct = catalogViewModel.selectedProduct {
                                            if selectedProduct.selectedSize?.isInSale == true,
                                               let salePrice = product.price.sale {
                                                Text(String(product.price.standard))
                                                    .strikethrough()
                                                    .font(Constant.AppFont.primary)
                                                    .foregroundStyle(.black)
                                                Text("\(salePrice) ₽")
                                                    .font(Constant.AppFont.primary)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.red)
                                            } else {
                                                Text("\(product.price.standard) ₽")
                                                    .font(Constant.AppFont.primary)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.black)
                                                
                                            }
                                        } else {
                                            Text("")
                                                .font(Constant.AppFont.primary)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.black)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            VStack(spacing: 16) {
                                HStack {
                                    Text(product.description)
                                        .font(Constant.AppFont.secondary)
                                        .foregroundStyle(.black)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack {
                                    var text: String = {
                                        if let selectedProduct = catalogViewModel.selectedProduct {
                                            return selectedProduct.selectedSize?.isInStock == true
                                            ? "В наличии"
                                            : "Нет в наличии"
                                        } else {
                                            return "Не выбран размер"
                                        }
                                    }()
                                    var color: Color = {
                                        if let selectedProduct = catalogViewModel.selectedProduct {
                                            return selectedProduct.selectedSize?.isInStock == true
                                            ? .green
                                            : .red
                                        } else {
                                            return .secondary
                                        }
                                    }()
                                    Text(text)
                                        .font(Constant.AppFont.secondary)
                                        .foregroundStyle(color)
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack {
                                    var text: String = {
                                        if let selectedProduct = catalogViewModel.selectedProduct {
                                            return selectedProduct.selectedSize?.isInStock == true
                                            ? "Этот товар есть в наличии и мы сможем отправить его сразу после оплаты."
                                            : "К сожалению, этого товара нет в наличии, но мы с удовольствием сошьем его для Вас после внесения оплаты."
                                        } else {
                                            return "Выберите размер и мы покажем информацию о наличии и цене"
                                        }
                                    }()
                                    Text(text)
                                        .font(Constant.AppFont.secondary)
                                        .foregroundStyle(.black)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                            }
                            Button {
                                // TODO: продолжить с алерта здесь
                                print(#function, "mytest - add to order: \(product.name)")
                                catalogViewModel.isAlertPresented = true
                                
                            } label: {
                                PrimaryButton(
                                    title: "Добавить в корзину",
                                    foregroundColor: .white,
                                    backgroundColor: .red
                                )
                            }
                            HStack {
                                let text = product.selectedSize?.isInStock == true
                                ? "Вам также может понравиться"
                                : "Похожие товары в наличии"
                                Text(text)
                                    .font(Constant.AppFont.primary)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                Spacer()
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 10) {
                                    ForEach(catalogViewModel.filteredProductList) { product in
                                        Button {
                                            router.navigate(to: .detail(product: product))
                                        } label: {
                                            ProductView(product: product)
                                        }
                                    }
                                }
                            }
                            
                        }
                        .padding(Const.viewInsets)
                    }
                }
            }
        }
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if product.selectedSize?.isInStock == true {
                    catalogViewModel.fetchProductList(
                        categoryName: product.categoryName,
                        exclude: product.name
                    )
                } else {
                    catalogViewModel.fetchProductList(
                        categoryName: product.categoryName,
                        isInStock: true
                    )
                }
            }
        }
        .sheet(
            isPresented: $catalogViewModel.isSheetPresented,
            content: {
                let values = catalogViewModel.sheetSelectType == .size
                ? product.sizes.first?.list
                : product.color.list
                ProductSheetView(
                    isPresented: $catalogViewModel.isSheetPresented,
                    type: catalogViewModel.sheetSelectType,
                    values: values ?? [],
                    onDismiss: {
                        newValue in
                        switch catalogViewModel.sheetSelectType {
                        case .color:
                            if let product = catalogViewModel.getProduct(
                                name: product.name,
                                colorName: newValue
                            ) {
                                router.navigate(to: .detail(product: product))
                            }
                        case .size:
                            if let size = product.sizes.first(where: { $0.name == newValue }) {
                                catalogViewModel.selectedProduct = product
                                catalogViewModel.selectedProduct?.selectedSize = size
                            }
                        }
                    }
                )
                .presentationDetents([.height(250)])
                .presentationDragIndicator(.visible)
            })
        .alert(
            catalogViewModel.alertTitle,
            isPresented: $catalogViewModel.isAlertPresented) {
                if catalogViewModel.selectedProduct != nil {
                    Button("В Корзину", role: .cancel) {
                        print(#function, "mytest - to basket tap")
                    }
                    Button("Продолжить") {
//                        catalogViewModel.isAlertPresented = false
                    }
                } else {
                    Button("OK") {
//                        catalogViewModel.isAlertPresented = false
                    }
                }
            }
    message: {
        Text(catalogViewModel.alertMessage)
    }
}

}

#Preview {
    ProductDetailView(product: MockData.mockProduct)
        .environmentObject(CatalogViewModel())
        .environmentObject(CatalogRouter())
}
