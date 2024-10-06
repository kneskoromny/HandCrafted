import SwiftUI

enum AlertType {
    
    // BasketView
    
    case unAuthUser(action: (() -> Void)?)
    case preOrder(totalPrice: Int, action: (() -> Void)?)
    case removeOrderItem(action: (() -> Void)?)
    
}

extension AlertType {
    
    var view: Alert {
        switch self {
        case .unAuthUser(let action):
            return Alert(
                title: Text("Ошибка авторизации"),
                message: Text("Чтобы заказывать товары Вам нужно авторизоваться в приложении."),
                primaryButton: .default(
                    Text("Авторизоваться"),
                    action: action
                ) ,
                secondaryButton: .cancel(Text("Отмена"))
            )
        case .preOrder(let totalPrice, let action):
            return Alert(
                title: Text("Почти готово!"),
                message: Text("Вы подтверждаете заказ на общую сумму \(totalPrice) ₽?"),
                primaryButton: .default(
                    Text("Подтверждаю"),
                    action: action
                ),
                secondaryButton: .cancel(Text("Отмена"))
            )
        case .removeOrderItem(let action):
            return Alert(
                title: Text("Удалить?"),
                message: Text("Вы точно хотите удалить товар из Корзины??"),
                primaryButton: .default(
                    Text("Удалить"),
                    action: action
                ),
                secondaryButton: .cancel(Text("Отмена"))
            )
        }
    }
}
