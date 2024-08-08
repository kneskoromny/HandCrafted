import SwiftUI

struct PrimaryTextField: View {
    
    var placeholder: LocalizedStringKey
    var error: LocalizedStringKey?
    @Binding var value: String
    
    var body: some View {
        VStack {
            HStack {
                Text(placeholder)
                    .font(.caption)
                    .foregroundStyle(.gray)
                Spacer()
            }
            TextField(
                "",
                text: $value
            )
            .textFieldStyle(.plain)
            .font(.title2)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            if let error {
                HStack {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .clipped()
        .shadow(
            color: Color.gray,
            radius: 1,
            x: 0,
            y: 0
        )
    }
}

#Preview {
    PrimaryTextField(
        placeholder: "email",
        value: .constant("test@mail.ru")
    )
}
