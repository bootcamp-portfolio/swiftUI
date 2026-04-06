import SwiftUI

struct CardRowView: View {
    
    let item: CardItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            AsyncImage(url: URL(string: item.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .clipped()
                    
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 60, height: 60)
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                    
                @unknown default:
                    EmptyView()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(item.category)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(item.title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .lineLimit(2)
            
            Text("WRITTEN BY \(item.writer.uppercased())")
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.gray.opacity(0.25), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}
