import SwiftUI

struct NoImageView: View {
    
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Image("noImage", label: Text("placeholder"))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
    }
    
}

#Preview {
    NoImageView(width: 150, height: 175)
}
