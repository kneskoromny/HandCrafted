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
    @Binding var value: String
    @Binding var error: String
    
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
                do {
                    try inputType.validate(value)
                } catch {
                    self.error = error.localizedDescription
                }
            }
            if error != "" {
                HStack {
                    Text(error)
                        .font(Constant.AppFont.thirdly)
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
        value: .constant("kneskoromny@gmail.com"),
        error: .constant("")
    )
}
