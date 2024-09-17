import SwiftUI

struct ProductSheetView: View {
    
    let sizes = ["XS", "S", "M", "L", "XL", "XXL"] // Массив размеров
    
    @State var isSizeTablePresented = false
    @Binding var isPresented: Bool
    var type: CatalogViewModel.SheetSelectType
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
                ForEach(sizes, id: \.self) { size in
                    Button(action: {
                        print("Выбран размер: \(size)")
                        onDismiss?(size)
                        isPresented = false
                    }) {
                        SecondaryButton(
                            title: "\(size)",
                            font: .body,
                            foregroundColor: .gray,
                            backgroundColor: .white,
                            height: 32
                        )
                    }
                }
            }
            if type == .size {
                Button {
                    isSizeTablePresented = true
                } label: {
                    Text("Таблица размеров")
                        .font(Constant.AppFont.secondary)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding()
        .sheet(isPresented: $isSizeTablePresented, content: {
            Rectangle()
                .foregroundStyle(.foreground)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        })
    }
}

#Preview {
    ProductSheetView(isPresented: .constant(true), type: .size)
}
