import SwiftUI

final class CatalogViewModel: ObservableObject {
    
    @Published var categoryList: [Category] = []
    @Published var productList: [Product] = []
    @Published var isLoading = false
    
    private let dbManager = DatabaseManager()
    
    // MARK: - Public Methods
    
    func fetchData() {
        isLoading = true
        Task {
            do {
                let productList = try await fetchProductList()
                let categoryList = try await fetchCategoryList()
                await MainActor.run {
                    self.productList = productList
                    self.categoryList = categoryList
                    isLoading = false
                }
            } catch {
                print(#function, "mytest - error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func fetchProductList() async throws -> [Product] {
        return try await dbManager.getProductList()
    }
    
    private func fetchCategoryList() async throws -> [Category] {
        return try await dbManager.getCategoryList()
    }
    
}
