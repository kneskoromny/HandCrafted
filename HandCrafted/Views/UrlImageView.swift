import SwiftUI

struct UrlImageView: View {
    
    var urlString: String?
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        if let urlString,
           let url = URL(string: urlString) {
            AsyncImage(url: url,
                       content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            },
                       placeholder: {
                ProgressView()
            })
            .frame(width: width, height: height)
            .clipped()
        } else {
            NoImageView(width: width, height: height)
        }
    }
    
}

#Preview {
    UrlImageView(width: 100, height: 100)
}
