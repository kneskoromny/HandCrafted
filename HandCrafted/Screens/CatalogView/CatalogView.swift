import SwiftUI

struct CatalogView: View {
    
    // MARK: - State
    
    @EnvironmentObject var viewModel: CatalogViewModel
    @EnvironmentObject var router: CatalogRouter
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                List(viewModel.categoryList) { category in
                    Button {
                        router.navigate(to: .list(MockData.products))
                    } label: {
                        CategoryView(category: category)
                    }
                    .tint(Color.black)
                    .listRowInsets(EdgeInsets())
                }
                .scrollIndicators(.hidden)
                .contentMargins(16)
                .listRowSpacing(16)
                .listStyle(.insetGrouped)
                
            }
        }
        .navigationTitle("Каталог")
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.fetchData()
        }
    }
}

#Preview {
    CatalogView()
        .environmentObject(CatalogViewModel())
}
