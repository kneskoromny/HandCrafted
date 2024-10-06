import SwiftUI

final class CatalogViewModel: ObservableObject {
    
    // MARK: - Types
    
    enum SheetSelectType {
        case size, color
    }
    
    // MARK: - Observable
    
    @Published var categoryList: [Category] = []
    @Published var productList: [Product] = []
    @Published var filteredProductList: [Product] = []
    @Published var selectedProduct: Product?
    
    @Published var isLoading = false
    @Published var isSheetPresented = false {
        // FIXME: сворачивается шит при открытии новой карточки из похожих и тапе на размер/цвет
        didSet {
//            print(#function, "mytest - is presented: \(isSheetPresented)")
        }
    }
    @Published var isAlertPresented = false
    
    // MARK: - Internal Properties
    
    var sheetSelectType: SheetSelectType = .size
    
    // MARK: - Private Propertied
    
    private let dbManager = DatabaseManager()
    
    // MARK: - Private Methods
    
    private func fetchProductList() async throws -> [Product] {
        return try await dbManager.getProductList()
    }
    
    private func fetchCategoryList() async throws -> [Category] {
        return try await dbManager.getCategoryList()
    }
    
}

// MARK: - Computed Properties

extension CatalogViewModel {
    
    var alertTitle: String {
        return selectedProduct == nil ? "Выберите размер" : "Отличный выбор 🙏"
    }
    var alertMessage: String {
        return selectedProduct == nil ? "" : "Продолжить покупки?"
    }
    
    var sizeSelectButtonTitle: String? {
        if selectedProduct == nil {
            return "Выберите"
        } else {
            return selectedProduct?.selectedSize?.name
        }
    }
    
    var sizeSelectButtonColor: Color {
        return selectedProduct == nil ? .secondary : .primary
    }
    
    var availabilityLabelText: String {
        if let selectedProduct {
            return selectedProduct.selectedSize?.isInStock == true
            ? "В наличии"
            : "Нет в наличии"
        } else {
            return "Не выбран размер"
        }
    }
    var availabilityLabelColor: Color {
        if let selectedProduct {
            return selectedProduct.selectedSize?.isInStock == true
            ? .green
            : .red
        } else {
            return .secondary
        }
    }
    
    var availabilityInfoText: String {
        if let selectedProduct {
            return selectedProduct.selectedSize?.isInStock == true
            ? "Этот товар есть в наличии и мы сможем отправить его сразу после оплаты."
            : "К сожалению, этого товара нет в наличии, но мы с удовольствием сошьем его для Вас после внесения оплаты."
        } else {
            return "Выберите размер и мы покажем информацию о наличии и цене"
        }
    }
    
    var similarProductsTitle: String {
        if let selectedProduct,
           selectedProduct.selectedSize?.isInStock == true {
            return "Вам также может понравиться"
        } else {
            return "Похожие товары в наличии"
        }
    }
    
}

// MARK: - Network Methods

extension CatalogViewModel {
    
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
    
}

// MARK: - Filter Methods

extension CatalogViewModel {
    
    func filterProductList(categoryName: String) {
        guard !productList.isEmpty else {
            print(#function, "mytest - error: no loaded product list")
            return
        }
        filteredProductList = productList
            .filter { $0.categoryName == categoryName }
            .sorted(by: { $0.name < $1.name })
    }
    
    func filterProductList(categoryName: String, exclude productName: String) {
        guard !productList.isEmpty else {
            print(#function, "mytest - error: no loaded product list")
            return
        }
        filteredProductList = productList
            .filter { $0.categoryName == categoryName && $0.name != productName }
    }
    
    func filterProductList(categoryName: String, isInStock: Bool) {
        guard !productList.isEmpty else {
            print(#function, "mytest - error: no loaded product list")
            return
        }
        productList.forEach({ product in
            if product.categoryName == categoryName {
                if let isInStock = product.sizes.first(where: { $0.isInStock == true }) {
                    filteredProductList.append(product)
                }
            }
        })
    }
    
    func getProduct(name: String, colorName: String) -> Product? {
        return filteredProductList.first { product in
            product.name == name && product.color.name == colorName
        }
    }
    
}

// MARK: - User Interaction Methods

extension CatalogViewModel {
    
    func selectButtonTapped(type: SheetSelectType) {
        sheetSelectType = type
        isSheetPresented = true
    }
    
    func addToCartButtonTapped() {
        isAlertPresented = true
    }
    
    func removeSelectedProduct() {
        selectedProduct = nil
    }
    
    func clearFilteredProductList() {
        filteredProductList = []
    }
    
}
