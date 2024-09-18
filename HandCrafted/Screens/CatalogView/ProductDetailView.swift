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
    
    @EnvironmentObject var viewModel: CatalogViewModel
    @EnvironmentObject var router: CatalogRouter
    
    var screenWidth: CGFloat = {
        return UIScreen.main.bounds.width
    }()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Минуточку...")
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 24) {
                        if let imageUrls = viewModel.selectedProduct?.imageUrls {
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
                                Button {
                                    viewModel.sheetSelectType = .size
                                    viewModel.isSheetPresented = true
                                } label: {
                                    let title = LocalizedStringKey((viewModel.selectedProduct?.selectedSize!.name)!)
                                    let isSelectable = (viewModel.selectedProduct?.sizes.count)! > 1
                                    SelectableButton(
                                        title: title,
                                        font: Constant.AppFont.secondary,
                                        height: 44,
                                        isSelectable: isSelectable
                                    )
                                }
                                .disabled(!((viewModel.selectedProduct?.sizes.count)! > 1))
                                Button {
                                    viewModel.sheetSelectType = .color
                                    viewModel.isSheetPresented = true
                                } label: {
                                    let title = LocalizedStringKey((viewModel.selectedProduct?.color.name)!)
                                    let isSelectable = (viewModel.selectedProduct?.color.list.count)! > 1
                                    SelectableButton(
                                        title: title,
                                        font: Constant.AppFont.secondary,
                                        height: 44,
                                        isSelectable: isSelectable
                                    )
                                }
                                .disabled(!((viewModel.selectedProduct?.color.list.count)! > 1))
                            }
                            HStack {
                                VStack(spacing: 8) {
                                    HStack {
                                        Text(viewModel.selectedProduct!.name)
                                            .font(Constant.AppFont.primary)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                        Spacer()
                                        
                                    }
                                    HStack {
                                        Text(viewModel.selectedProduct!.composition)
                                            .font(Constant.AppFont.secondary)
                                            .foregroundStyle(.gray)
                                        Spacer()
                                    }
                                }
                                Spacer()
                                VStack {
                                    HStack {
                                        Spacer()
                                        if let salePrice = viewModel.selectedProduct?.price.sale {
                                            Text(String((viewModel.selectedProduct?.price.standard)!))
                                                .strikethrough()
                                                .font(Constant.AppFont.primary)
                                                .foregroundStyle(.black)
                                            Text("\(salePrice) ₽")
                                                .font(Constant.AppFont.primary)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.red)
                                        } else {
                                            if let standardPrice = viewModel.selectedProduct?.price.standard {
                                                Text("\(standardPrice) ₽")
                                                    .font(Constant.AppFont.primary)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.black)
                                            }
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            VStack(spacing: 16) {
                                HStack {
                                    Text(viewModel.selectedProduct!.description)
                                        .font(Constant.AppFont.secondary)
                                        .foregroundStyle(.black)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack {
                                    let text = (viewModel.selectedProduct?.selectedSize!.isInStock)! ? "В наличии" : "Нет в наличии"
                                    let color: Color = (viewModel.selectedProduct?.selectedSize!.isInStock)! ? .green : .red
                                    Text(text)
                                        .font(Constant.AppFont.secondary)
                                        .foregroundStyle(color)
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack {
                                    let text = (viewModel.selectedProduct?.selectedSize!.isInStock)! ? "Этот товар есть в наличии и мы сможем отправить его сразу после оплаты." : "К сожалению, этого товара нет в наличии, но мы с удовольствием сошьем его для Вас после внесения оплаты."
                                    Text(text)
                                        .font(Constant.AppFont.secondary)
                                        .foregroundStyle(.black)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                            }
                            Button {
                                print(#function, "mytest - btn tapped")
                            } label: {
                                PrimaryButton(
                                    title: "Добавить в корзину",
                                    foregroundColor: .white,
                                    backgroundColor: .red
                                )
                                
                            }
                            HStack {
                                let text = (viewModel.selectedProduct?.selectedSize!.isInStock)! ? "Вам также может понравиться" : "Похожие товары в наличии"
                                Text(text)
                                    .font(Constant.AppFont.primary)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                Spacer()
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 10) {
                                    ForEach(viewModel.filteredProductList) { product in
                                        Button {
                                            viewModel.selectedProduct = product
                                            router.navigate(to: .detail)
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
                if (viewModel.selectedProduct?.selectedSize!.isInStock)! {
                    viewModel.fetchProductList(categoryName: viewModel.selectedProduct!.categoryName, exclude: viewModel.selectedProduct!.name)
                } else {
                    viewModel.fetchProductList(categoryName: viewModel.selectedProduct!.categoryName, isInStock: true)
                }
            }
        }
        .sheet(
            isPresented: $viewModel.isSheetPresented,
            content: {
                let values = viewModel.sheetSelectType == .size
                ? viewModel.selectedProduct?.sizes.first?.list
                : viewModel.selectedProduct?.color.list
                ProductSheetView(
                    isPresented: $viewModel.isSheetPresented,
                    type: viewModel.sheetSelectType,
                    values: values ?? [],
                    onDismiss: { newValue in
                        viewModel.updateSelectedProduct(with: newValue)
                    }
                )
                    .presentationDetents([.height(250)])
                    .presentationDragIndicator(.visible)
            })
    }
}

#Preview {
    ProductDetailView()
        .environmentObject(CatalogViewModel())
}
