import SwiftUI

final class CatalogViewModel: ObservableObject {
    
    enum SheetSelectType {
        case size, color
    }
    
    @Published var categoryList: [Category] = []
    @Published var productList: [Product] = []
    @Published var filteredProductList: [Product] = []
    @Published var selectedProduct: Product?
    
    @Published var isLoading = false
    @Published var isSheetPresented = false
    
    @Published var isAlertPresented = false
    var alertTitle: String {
        return selectedProduct == nil ? "Выберите размер" : "Отличный выбор 🙏"
    }
    var alertMessage: String {
        return selectedProduct == nil ? "" : "Продолжить покупки?"
    }
    
    @Published var selectedSize: String = "M"
    @Published var selectedColor: String = "Белый"
    
    var sheetSelectType: SheetSelectType = .size
    
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
        filteredProductList = productList.filter { $0.categoryName == categoryName }.sorted(by: { $0.name < $1.name })
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
        filteredProductList = productList.filter { $0.categoryName == categoryName }
        // TODO: разобраться здесь
//        filteredProductList = productList.filter { $0.categoryName == categoryName && $0.isInStock == isInStock }
    }
    
    func getProduct(name: String, colorName: String) -> Product? {
        return filteredProductList.first { product in
            product.name == name && product.color.name == colorName
        }
    }
    
//    func updateSelectedProduct(with value: String) {
//        switch sheetSelectType {
//        case .size:
//            let selectedSize = selectedProduct?.sizes.first(where: { $0.name == value })
//            selectedProduct?.selectedSize = selectedSize
//        case .color:
//            selectedProduct = productList
//                .first(where: { $0.name == selectedProduct?.name && $0.color.name == value })
//        }
//    }
    
    // MARK: - Private Methods
    
    private func fetchProductList() async throws -> [Product] {
        return try await dbManager.getProductList()
    }
    
    private func fetchCategoryList() async throws -> [Category] {
        return try await dbManager.getCategoryList()
    }
    
}
