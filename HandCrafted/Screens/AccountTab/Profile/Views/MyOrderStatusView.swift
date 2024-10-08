import SwiftUI

struct MyOrderStatusView: View {
    
    var status: OrderStatus
    var nextStatus: OrderStatus? {
        return OrderStatus(rawValue: status.rawValue + 1)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 8) {
                HStack {
                    HStack {
                        Text("Текущий статус:")
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.secondary)
                        Text(status.description.lowercased())
                            .font(Constant.AppFont.thirdly)
                            .foregroundStyle(.primary)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    if status != .delivered {
                        HStack {
                            Text("далее:")
                                .font(Constant.AppFont.thirdly)
                                .foregroundStyle(.secondary)
                            Text(nextStatus?.description.lowercased() ?? "")
                                .font(Constant.AppFont.thirdly)
                                .foregroundStyle(.primary)
                                .fontWeight(.semibold)
                        }
                    }
                }
                HStack(spacing: 2) {
                    StatusProgressView(
                        status: .created,
                        current: status,
                        geometry: geometry
                    )
                    StatusProgressView(
                        status: .confirmed,
                        current: status,
                        geometry: geometry
                    )
                    StatusProgressView(
                        status: .inProcess,
                        current: status,
                        geometry: geometry
                    )
                    StatusProgressView(
                        status: .ready,
                        current: status,
                        geometry: geometry
                    )
                    StatusProgressView(
                        status: .delivered,
                        current: status,
                        geometry: geometry
                    )
                }
            }
        }
    }
}

#Preview {
    MyOrderStatusView(status: .created)
}

struct StatusProgressView: View {
    
    var status: OrderStatus
    var current: OrderStatus
    var geometry: GeometryProxy
    
    var isAchieved: Bool {
        status.rawValue <= current.rawValue
    }
    
    
    var width: CGFloat {
        let spacingSum = CGFloat((OrderStatus.allCases.count - 1) * 2)
        let statusesCount = CGFloat(OrderStatus.allCases.count)
        return (geometry.size.width - spacingSum) / statusesCount
    }
    
    var color: Color {
        return isAchieved
        ? Color(uiColor: .systemGreen.withAlphaComponent(1))
        : Color(uiColor: .systemGreen.withAlphaComponent(0.5))
    }
    
    var isLeadingRoundedCorners: Bool {
        return status == .created
    }
    
    var isTrailingRoundedCorners: Bool {
        return status == .delivered
    }
    
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .frame(width: width, height: 10)
            .clipShape(
                .rect(
                    topLeadingRadius: isLeadingRoundedCorners ? 4 : 0,
                    bottomLeadingRadius: isLeadingRoundedCorners ? 4 : 0,
                    bottomTrailingRadius: isTrailingRoundedCorners ? 4 : 0,
                    topTrailingRadius: isTrailingRoundedCorners ? 4 : 0
                   )
            )
    }
    
}
