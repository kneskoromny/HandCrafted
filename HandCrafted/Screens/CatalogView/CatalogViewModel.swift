import SwiftUI

final class CatalogViewModel: ObservableObject {
    
    @Published var categoryList: [Category] = []
    @Published var productList: [Product] = []
    @Published var isLoading = false
    
    private let dbManager = DatabaseManager()
    
    private let dispatchGroup = DispatchGroup()
    
    // MARK: -
    
    func fetchData() {
        isLoading = true
        Task {
            let productList = await fetchProductList()
            let categoryList = await fetchCategoryList()
            await MainActor.run {
                self.productList = productList
                self.categoryList = categoryList
                isLoading = false
            }
        }
    }
    
    // MARK: -
    
    private func fetchProductList() async -> [Product] {
        await DatabaseManager.getMockProductList()
    }
    
    private func fetchCategoryList() async -> [Category] {
        await DatabaseManager.getMockCategoryList()
    }
    
}
