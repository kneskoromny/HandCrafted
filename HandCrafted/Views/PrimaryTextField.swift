import SwiftUI

struct PrimaryTextField: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
    }
    var inputType: InputType
    @Binding var isDisabled: Bool
    @Binding var value: String
    @Binding var error: String
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(inputType.placeholder)
                    .font(Constant.AppFont.thirdly)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            TextField(
                "",
                text: $value
            )
            .disabled(isDisabled)
            .textFieldStyle(.plain)
            .font(Constant.AppFont.secondary)
            .foregroundStyle(.primary)
            .disableAutocorrection(true)
            .textInputAutocapitalization(inputType.autocapitalization)
            .keyboardType(inputType.keyboardType)
            .textContentType(inputType.textContentType)
            .onChange(of: value) { oldValue, newValue in
                value = inputType.format(newValue)
                self.error = ""
            }
            .focused($isFocused)
            .onChange(of: isFocused) { _, isFocused in
                if !isFocused {
                    do {
                        if try inputType.isValid(value) {
                            self.error = ""
                        }
                    } catch {
                        self.error = error.localizedDescription
                    }
                }
            }
            if error != "" {
                HStack {
                    Text(error)
                        .font(Constant.AppFont.thirdly)
                        .foregroundStyle(.red)
                    Spacer()
                }
                .padding(.top)
            }
        }
        .padding(Const.viewInsets)
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(10)
        .clipped()
    }
}

#Preview {
    PrimaryTextField(
        inputType: .email,
        isDisabled: .constant(false),
        value: .constant("kneskoromny@gmail.com"),
        error: .constant("")
    )
}
