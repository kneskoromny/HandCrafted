import SwiftUI

struct ProductListView: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
    }
    
    @EnvironmentObject var catVm: CatalogViewModel
    @EnvironmentObject var router: AppRouter
    
    var category: Category
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            if catVm.isLoading {
                ProgressView("Минуточку...")
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 32) {
                        ForEach(catVm.filteredProductList) { product in
                            Button {
                                router.navigate(to: .productDetail(product))
                            } label: {
                                ProductView(product: product)
                            }
                        }
                    }
                    .padding(Const.viewInsets)
                }
            }
        }
        .navigationTitle(category.name)
        .padding(Const.viewInsets)
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
            catVm.filterProductList(categoryName: category.name)
        }
    }
}

#Preview {
    ProductListView(
        category: MockData.categories.first!
    )
        .environmentObject(CatalogViewModel())
        .environmentObject(AppRouter())
}
