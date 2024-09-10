import SwiftUI

struct ProductListView: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 16,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
    }
    
    @EnvironmentObject var viewModel: CatalogViewModel
    @EnvironmentObject var router: CatalogRouter
    
    var category: Category
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Минуточку...")
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 32) {
                        ForEach(viewModel.filteredProductList) { product in
                            ProductView(product: product)
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
            viewModel.fetchProductList(for: category)
        }
    }
}

#Preview {
    ProductListView(category: MockData.categories.first!)
        .environmentObject(CatalogViewModel())
}
