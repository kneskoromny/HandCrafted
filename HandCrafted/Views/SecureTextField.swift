import SwiftUI

struct SecureTextField: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
    }
    var inputType: InputType
    @Binding var value: String
    @Binding var comparsionValue: String
    @Binding var error: String
    
    @State private var isSecure: Bool = true
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(inputType.placeholder)
                    .font(Constant.AppFont.thirdly)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            HStack {
                ZStack {
                    TextField(
                        "",
                        text: $value
                    )
                    .opacity(isSecure ? 0 : 1)
                    SecureField(
                        "",
                        text: $value
                    )
                    .opacity(isSecure ? 1 : 0)
                }
                .textFieldStyle(.plain)
                .font(Constant.AppFont.secondary)
                .foregroundStyle(.primary)
                .disableAutocorrection(true)
                .textInputAutocapitalization(inputType.autocapitalization)
                .keyboardType(inputType.keyboardType)
                .textContentType(.oneTimeCode)
                .onChange(of: value) { _, _ in
                    self.error = ""
                }
                .focused($isFocused)
                .onChange(of: isFocused) { _, isFocused in
                    if !isFocused {
                        do {
                            let success = try inputType.isValid(value)
                            if success {
                                self.error = ""
                            } else {
                                self.error = value == comparsionValue ? "" : InputValidateError.confirm.localizedDescription
                            }
                        } catch {
                            self.error = error.localizedDescription
                        }
                    }
                }
                Button {
                    isSecure.toggle()
                } label: {
                    Image(
                        isSecure ? "eyeOpened" : "eyeClosed",
                        label: Text("EyeButtonImage")
                    )
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
    SecureTextField(
        inputType: .password,
        value: .constant("1234"),
        comparsionValue: .constant("123"),
        error: .constant("Пароли не совпадают")
    )
}
