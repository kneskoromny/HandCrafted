import SwiftUI

final class CatalogViewModel: ObservableObject {
    
    @Published var categoryList: [Category] = []
    @Published var productList: [Product] = []
    @Published var filteredProductList: [Product] = []
    @Published var isLoading = false
    
    private let dbManager = DatabaseManager()
    
    // MARK: - Public Methods
    
    func fetchData() {
        guard categoryList.isEmpty else { return }
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
    
    func fetchProductList(categoryName: String) {
        guard !productList.isEmpty else {
            print(#function, "mytest - error: no loaded product list")
            return
        }
        isLoading = true
        filteredProductList = productList.filter { $0.categoryName == categoryName }
        isLoading = false
    }
    
    func fetchProductList(categoryName: String, exclude productName: String) {
        guard !productList.isEmpty else {
            print(#function, "mytest - error: no loaded product list")
            return
        }
        filteredProductList = productList.filter { $0.categoryName == categoryName && $0.name != productName }
    }
    
    func fetchProductList(categoryName: String, isInStock: Bool) {
        guard !productList.isEmpty else {
            print(#function, "mytest - error: no loaded product list")
            return
        }
        filteredProductList = productList.filter { $0.categoryName == categoryName && $0.isInStock == isInStock }
    }
    
    // MARK: - Private Methods
    
    private func fetchProductList() async throws -> [Product] {
        return try await dbManager.getProductList()
    }
    
    private func fetchCategoryList() async throws -> [Category] {
        return try await dbManager.getCategoryList()
    }
    
}
