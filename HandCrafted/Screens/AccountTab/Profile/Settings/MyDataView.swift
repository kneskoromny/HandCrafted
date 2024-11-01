import PhotosUI
import SwiftUI

struct MyDataView: View {
    
    private enum Const {
        static let viewInsets = EdgeInsets(
            top: 16,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
        static let buttonsInsets = EdgeInsets(
            top: 8,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
    }
    
    @StateObject var myDataVm = MyDataViewModel()
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        VStack {
            if myDataVm.isLoading {
                ProgressView("Минуточку...")
            } else {
                List {
                    // Имя, Дата рождения, Город, Номер телефона
                    Section {
                        PrimaryTextField(
                            inputType: .name,
                            isDisabled: $myDataVm.isDisabled,
                            value: $myDataVm.userData.name,
                            error: $myDataVm.errorData.name
                        )
                        PrimaryTextField(
                            inputType: .birthDate,
                            isDisabled: $myDataVm.isDisabled,
                            value: $myDataVm.userData.birthDate,
                            error: $myDataVm.errorData.birthDate
                        )
                        PrimaryTextField(
                            inputType: .city,
                            isDisabled: $myDataVm.isDisabled,
                            value: $myDataVm.userData.city,
                            error: $myDataVm.errorData.city
                        )
                        PrimaryTextField(
                            inputType: .phone,
                            isDisabled: $myDataVm.isDisabled,
                            value: $myDataVm.userData.phone,
                            error: $myDataVm.errorData.phone
                        )
                    }
                    .listRowInsets(EdgeInsets())
                    
                    // Кнопка
                    Section {
                        Button {
                            if myDataVm.isDisabled {
                                myDataVm.isDisabled = false
                            } else {
                               print(#function, "mytest - отправка запроса на изменение данных в Realtime Database")
                                // TODO: запрос на изменение данных в RealTime Database
                            }
                        } label: {
                            PrimaryButton(title: myDataVm.isDisabled ? "Изменить" : "Сохранить")
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    
                    // E-mail, Пароль,
                    Section {
                        Button {
                            print(#function, "mytest - переход на изменение email")
                        } label: {
                            // TODO: email должен быть из User
                            ProfileButton(
                                title: "E-mail",
                                subtitle: myDataVm.userData.email
                            )
                        }
                        .tint(.primary)
                        Button {
                            print(#function, "mytest - переход на изменение пароля")
                        } label: {
                            ProfileButton(
                                title: "Пароль",
                                subtitle: "**********"
                            )
                        }
                        .tint(.primary)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.insetGrouped)
                .scrollIndicators(.hidden)
                .listSectionSpacing(24)
                .contentMargins(.top, 16)
            }
        }
        .navigationTitle("Мои данные")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.navigateBack()
                } label: {
                    Label("Back", systemImage: "arrow.left")
                }
                .tint(.red)
            }
        }
        .onAppear {
            myDataVm.getUser()
        }
    }
}

#Preview {
    MyDataView()
}
