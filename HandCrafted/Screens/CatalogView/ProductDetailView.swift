import SwiftUI

struct ProductDetailView: View {
    
    // MARK: - Types
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
    }
    
    // MARK: - Observables
    
    @EnvironmentObject var catVm: CatalogViewModel
    @EnvironmentObject var basVm: BasketViewModel
    @EnvironmentObject var router: AppRouter
    
    // MARK: - Internal Properties
    
    var product: Product
    var screenWidth: CGFloat = {
        return UIScreen.main.bounds.width
    }()
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if catVm.isLoading {
                ProgressView("Минуточку...")
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 24) {
                        if let imageUrls = product.imageUrls {
                            ProductImagesScrollView(
                                strUrls: imageUrls,
                                screenWidth: screenWidth
                            )
                        } else {
                            NoImageView(
                                width: screenWidth - 16,
                                height: screenWidth * 1.15
                            )
                        }
                        VStack(spacing: 32) {
                            HStack(spacing: 16) {
                                VStack(spacing: 8) {
                                    HStack {
                                        Text("Размер")
                                        Spacer()
                                    }
                                    Button {
                                        catVm.selectButtonTapped(type: .size)
                                    } label: {
                                        SelectableButton(
                                            title: catVm.sizeSelectButtonTitle,
                                            font: Constant.AppFont.secondary,
                                            height: 44,
                                            disabled: product.sizes.count < 2
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
                                        catVm.selectButtonTapped(type: .color)
                                    } label: {
                                        SelectableButton(
                                            title: product.color.name,
                                            font: Constant.AppFont.secondary,
                                            height: 44,
                                            disabled: product.color.list.count < 2
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
                                            .foregroundStyle(.primary)
                                        Spacer()
                                        
                                    }
                                    HStack {
                                        Text(product.composition)
                                            .font(Constant.AppFont.secondary)
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                    }
                                }
                                Spacer()
                                VStack {
                                    HStack {
                                        Spacer()
                                        PriceView(product: catVm.selectedProduct)
                                    }
                                    Spacer()
                                }
                            }
                            VStack(spacing: 16) {
                                HStack {
                                    Text(product.description)
                                        .font(Constant.AppFont.secondary)
                                        .foregroundStyle(.primary)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack {
                                    Text(catVm.availabilityLabelText)
                                        .font(Constant.AppFont.secondary)
                                        .foregroundStyle(catVm.availabilityLabelColor)
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack {
                                    Text(catVm.availabilityInfoText)
                                        .font(Constant.AppFont.secondary)
                                        .foregroundStyle(.primary)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                            }
                            Button {
                                catVm.addToCartButtonTapped()
                            } label: {
                                PrimaryButton(
                                    title: "Добавить в корзину",
                                    foregroundColor: .white, // color
                                    backgroundColor: .red // color
                                )
                            }
                            HStack {
                                Text(catVm.similarProductsTitle)
                                    .font(Constant.AppFont.primary)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                                Spacer()
                            }
                            SimilarProductsScrollView()
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
                    catVm.removeSelectedProduct()
                    catVm.clearFilteredProductList()
                    router.navigateBack()
                } label: {
                    Label("Back", systemImage: "arrow.left")
                }
                .tint(.red)
            }
        }
        .onAppear {
            if product.sizes.count < 2 {
                catVm.selectedProduct = product
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if product.selectedSize?.isInStock == true {
                    catVm.filterProductList(
                        categoryName: product.categoryName,
                        exclude: product.name
                    )
                } else {
                    catVm.filterProductList(
                        categoryName: product.categoryName,
                        isInStock: true
                    )
                }
            }
        }
        .onTapGesture {
            print(#function, "mytest - tap gesture")
        }
        .sheet(
            isPresented: $catVm.isSheetPresented,
            content: {
                let values = catVm.sheetSelectType == .size
                ? product.sizes.first?.list
                : product.color.list
                ProductSheetView(
                    isPresented: $catVm.isSheetPresented,
                    type: catVm.sheetSelectType,
                    values: values ?? [],
                    onDismiss: {
                        newValue in
                        switch catVm.sheetSelectType {
                        case .color:
                            if let product = catVm.getProduct(
                                name: product.name,
                                colorName: newValue
                            ) {
                                catVm.removeSelectedProduct()
                                catVm.clearFilteredProductList()
                                router.navigate(to: .detail(product: product))
                            }
                        case .size:
                            if let size = product.sizes.first(where: { $0.name == newValue }) {
                                catVm.selectedProduct = product
                                catVm.selectedProduct?.selectedSize = size
                            }
                        }
                    }
                )
                .presentationDetents([.height(250)])
                .presentationDragIndicator(.visible)
            })
        .alert(
            catVm.alertTitle,
            isPresented: $catVm.isAlertPresented) {
                if let selectedProduct = catVm.selectedProduct {
                    Button("В Корзину", role: .cancel) {
                        basVm.addToBasket(product: selectedProduct)
                        router.selectedTab = AppRouter.Tab.cart
                    }
                    Button("Продолжить") {
                        basVm.addToBasket(product: selectedProduct)
                    }
                } else {
                    Button("OK") {}
                }
            }
    message: {
        Text(catVm.alertMessage)
    }
}

}

#Preview {
    ProductDetailView(product: MockData.mockProduct)
        .environmentObject(CatalogViewModel())
        .environmentObject(AppRouter())
}

// MARK: - ProductImagesScrollView

struct ProductImagesScrollView: View {
    
    var strUrls: [String]
    var screenWidth: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach(strUrls.indices, id: \.self) { index in
                    if let url = URL(string: strUrls[index]) {
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
                        NoImageView(
                            width: screenWidth - 16,
                            height: screenWidth * 1.15
                        )
                    }
                }
            }
        }
    }
}

// MARK: - SimilarProductsScrollView

struct SimilarProductsScrollView: View {
    
    @EnvironmentObject var catVm: CatalogViewModel
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(catVm.filteredProductList) { product in
                    Button {
                        catVm.removeSelectedProduct()
                        catVm.clearFilteredProductList()
                        router.navigate(to: .detail(product: product))
                    } label: {
                        ProductView(product: product)
                    }
                }
            }
        }
    }
    
}

// MARK: - PriceView

struct PriceView: View {
    
    var product: Product?
    
    var body: some View {
        if let product {
            if product.selectedSize?.isInSale == true,
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
        }
    }
}
