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
    
    var product: Product
    
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
                            HStack {
                                Button {
                                    viewModel.sheetSelectType = .size
                                    viewModel.isSheetPresented = true
                                } label: {
                                    SelectableButton(
                                        title: "\(viewModel.selectedSize)",
                                        font: Constant.AppFont.secondary,
                                        foregroundColor: .black,
                                        backgroundColor: .white,
                                        height: 44,
                                        isSelectable: true
                                    )
                                }
                                Button {
                                    viewModel.sheetSelectType = .color
                                    viewModel.isSheetPresented = true
                                } label: {
                                    SelectableButton(
                                        title: "\(product.color.name)",
                                        font: Constant.AppFont.secondary,
                                        foregroundColor: .black,
                                        backgroundColor: .white,
                                        height: 44,
                                        isSelectable: true
                                    )
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
                                        Text("\(product.composition)")
                                            .font(Constant.AppFont.secondary)
                                            .foregroundStyle(.gray)
                                        Spacer()
                                    }
                                }
                                Spacer()
                                VStack {
                                    HStack {
                                        Spacer()
                                        if let salePrice = product.price.sale {
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
                                    // TODO: настроить здесь
//                                    let text = product.isInStock ? "В наличии" : "Нет в наличии"
//                                    let color: Color = product.isInStock ? .green : .red
                                    Text("Настроить отображение")
                                        .font(Constant.AppFont.secondary)
                                        .foregroundStyle(.green)
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack {
//                                    let text = product.isInStock ? "Этот товар есть в наличии и мы сможем отправить его сразу после оплаты." : "К сожалению, этого товара нет в наличии, но мы с удовольствием сошьем его для Вас после внесения оплаты."
                                    Text("Настроить отображение")
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
//                                let text = product.isInStock ? "Вам также может понравиться" : "Похожие товары в наличии"
                                Text("Настроить отображение")
                                    .font(Constant.AppFont.primary)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                Spacer()
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 10) {
                                    ForEach(viewModel.filteredProductList) { product in
                                        Button {
                                            router.navigate(to: .detail(product))
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
                // TODO: настроить здесь
//                if product.isInStock {
//                    viewModel.fetchProductList(categoryName: product.categoryName, exclude: product.name)
//                } else {
//                    viewModel.fetchProductList(categoryName: product.categoryName, isInStock: true)
//                }
            }
        }
        .sheet(
            isPresented: $viewModel.isSheetPresented,
            content: {
                ProductSheetView(
                    isPresented: $viewModel.isSheetPresented,
                    type: viewModel.sheetSelectType,
                    onDismiss: { size in
                        viewModel.selectedSize = size
                    }
                )
                    .presentationDetents([.height(300)])
                    .presentationDragIndicator(.visible)
            })
    }
}

#Preview {
    ProductDetailView(product: MockData.mockProduct).environmentObject(CatalogViewModel())
}
