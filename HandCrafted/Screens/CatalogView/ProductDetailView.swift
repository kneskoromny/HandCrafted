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
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Минуточку...")
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 32) {
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
                                            .frame(width: 300, height: 350)
                                            .clipped()
                                        } else {
                                            ZStack(alignment: .center) {
                                                Rectangle()
                                                    .foregroundStyle(.white)
                                                Text("👗")
                                                    .font(.largeTitle)
                                            }
                                            .frame(width: 300, height: 350)
                                        }
                                    }
                                }
                            }
                        } else {
                            // TODO: сделать нормальную заглушку
                            ZStack(alignment: .center) {
                                Rectangle()
                                    .foregroundStyle(.white)
                                Text("👗")
                                    .font(.largeTitle)
                            }
                            .frame(width: 300, height: 350)
                        }
                        VStack(spacing: 32) {
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
                                        Text("Ткань: \(product.fabric)")
                                            .font(Constant.AppFont.secondary)
                                            .foregroundStyle(.gray)
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Размер: \(product.size)")
                                            .font(Constant.AppFont.secondary)
                                            .foregroundStyle(.gray)
                                        Spacer()
                                    }
                                }
                                Spacer()
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text("\(product.price) ₽")
                                            .font(Constant.AppFont.primary)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black)
                                    }
                                    Spacer()
                                    Button {
                                        print(#function, "mytest - size table btn did tapped")
                                    } label: {
                                        SecondaryButton(
                                            title: "Таблица размеров",
                                            font: Constant.AppFont.secondary,
                                            foregroundColor: .gray,
                                            backgroundColor: .white,
                                            height: 32
                                        )
                                    }
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
                                    let text = product.isInStock ? "В наличии" : "Нет в наличии"
                                    let color: Color = product.isInStock ? .green : .red
                                    Text(text)
                                        .font(Constant.AppFont.secondary)
                                        .foregroundStyle(color)
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack {
                                    let text = product.isInStock ? "Этот товар есть в наличии и мы сможем доставить его сразу после оплаты." : "К сожалению, этого товара нет в наличии, но мы с удовольствием сошьем его для Вас после внесения оплаты."
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
                                let text = product.isInStock ? "Вам также может понравиться" : "Похожие товары в наличии"
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
                if product.isInStock {
                    viewModel.fetchProductList(categoryName: product.categoryName, exclude: product.name)
                } else {
                    viewModel.fetchProductList(categoryName: product.categoryName, isInStock: true)
                }
            }
        }
    }
}

#Preview {
    ProductDetailView(product: MockData.products.first!)
}
