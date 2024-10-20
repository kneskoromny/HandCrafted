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
    var placeholder: String
    @State var error: String?
    @Binding var value: String
    
    var body: some View {
        VStack {
            HStack {
                Text(placeholder)
                    .font(Constant.AppFont.thirdly)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            TextField(
                "",
                text: $value
            )
            .textFieldStyle(.plain)
            .font(Constant.AppFont.secondary)
            .foregroundStyle(.primary)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .keyboardType(inputType.keyboardType)
            .textContentType(inputType.textContentType)
            .onChange(of: value) { oldValue, newValue in
                print(#function, "mytest - old: \(oldValue), new: \(newValue)")
                value = inputType.format(newValue)
            }
            if let error {
                HStack {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                    Spacer()
                }
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
        placeholder: "E-mail",
        value: .constant("kneskoromny@gmail.com")
    )
}

struct EmailTextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
    }
    
}

struct PasswordTextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .textContentType(.password)
            .keyboardType(.asciiCapable)
    }
    
}
