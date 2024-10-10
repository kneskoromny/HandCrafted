import SwiftUI

struct ProductSheetView: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
    }
    
    @State var isSizeTablePresented = false
    @Binding var isPresented: Bool
    
    var type: CatalogViewModel.SheetSelectType
    var values: [String]
    var onDismiss: ((String) -> Void)?
    
    let columns = [
        GridItem(.fixed(UIScreen.main.bounds.width / 3), spacing: 32),
        GridItem(.fixed(UIScreen.main.bounds.width / 3), spacing: 32)
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            let text = type == .size ? "Выберите размер" : "Выберите цвет"
            Text(text)
                .font(Constant.AppFont.primary)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(values, id: \.self) { value in
                    Button(action: {
                        onDismiss?(value)
                        isPresented = false
                    }) {
                        SecondaryButton(
                            title: value
                        )
                    }
                }
            }
        }
        .padding(Const.viewInsets)
    }
}

#Preview {
    ProductSheetView(isPresented: .constant(true), type: .size, values: ["S", "M", "L", "XL"])
}
