import PhotosUI
import SwiftUI

struct SettingsView: View {
    
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
    
    @EnvironmentObject var viewModel: ProfileViewModel
    @EnvironmentObject var appRouter: AppRouter
    
    @State private var photosPickerItem: PhotosPickerItem? = nil
    @State var isPhotoPickerPresented = false
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                ScrollView {
                    VStack(alignment: .center, spacing: 8) {
                        if let urlString = viewModel.user.avatarUrl,
                           let url = URL(string: urlString) {
                            AsyncImage(url: url,
                                       content: { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(50)
                            },
                                       placeholder: {
                                ZStack(alignment: .center) {
                                    Circle()
                                    Text("😍")
                                        .font(.largeTitle)
                                }
                                .frame(width: 100, height: 100)
                                .cornerRadius(50)
                            })
                        } else {
                            ZStack(alignment: .center) {
                                Circle()
                                Text("😇")
                                    .font(.largeTitle)
                            }
                            .frame(width: 100, height: 100)
                            .cornerRadius(50)
                        }
                        
                        PhotosPicker(
                            selection: $photosPickerItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Text("Add photo")
                                    .font(Constant.AppFont.secondary)
                                    .foregroundStyle(.gray)
                            }
                            .onChange(of: photosPickerItem) { _, newValue in
                                Task {
                                    if let selectedImageData = try? await newValue?.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: selectedImageData) {
                                        let compressedData = uiImage.jpegData(compressionQuality: 0.3)
                                        viewModel.saveAvatar(data: compressedData)
                                    } else {
                                        print(#function, "krl_debug: error get image data")
                                    }
                                    //                                    do {
                                    //                                        let selectedImageData = try await newValue?.loadTransferable(type: Data.self)
                                    //                                        print(#function, "krl_test data: \(selectedImageData?.count)")
                                    //                                        let uiImage = UIImage(data: selectedImageData)
                                    //
                                    //                                    } catch let error {
                                    //                                        print(#function, "krl_test error: \(error)")
                                    //                                    }
                                }
                            }
                    }
                    .padding(Const.viewInsets)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Personal information")
                            .font(Constant.AppFont.secondary)
                        PrimaryTextField(
                            placeholder: "Name",
                            value: $viewModel.user.name.toUnwrapped(defaultValue: "")
                        )
                        PrimaryTextField(
                            placeholder: "Date of birth",
                            value: $viewModel.user.birthday.toUnwrapped(defaultValue: "")
                        )
                        HStack {
                            Text("E-mail")
                                .font(Constant.AppFont.secondary)
                            Spacer()
                            Button {
                                print(#function, "mytest - Change email button tapped")
                            } label: {
                                Text("Change")
                                    .font(Constant.AppFont.secondary)
                                    .tint(.gray)
                            }
                        }
                        PrimaryTextField(
                            placeholder: "E-mail",
                            value: $viewModel.user.email.toUnwrapped(defaultValue: "")
                        )
                        HStack {
                            Text("Password")
                                .font(Constant.AppFont.secondary)
                            Spacer()
                            Button {
                                print(#function, "mytest - Change password button tapped")
                            } label: {
                                Text("Change")
                                    .font(Constant.AppFont.secondary)
                                    .tint(.gray)
                            }
                        }
                        // TODO: password should be kept in keychain
                        PrimaryTextField(
                            placeholder: "Password",
                            value: $viewModel.user.password.toUnwrapped(defaultValue: "")
                        )
                        Text("Notifications")
                            .font(Constant.AppFont.secondary)
                        HStack {
                            Text("Sales")
                                .font(Constant.AppFont.secondary)
                            Spacer()
                            Toggle("", isOn: $viewModel.user.isSalesSubOn)
                        }
                        HStack {
                            Text("New arrivals")
                                .font(Constant.AppFont.secondary)
                            Spacer()
                            Toggle("", isOn: $viewModel.user.isNewArrivalsSubOn)
                        }
                        Button {
                            viewModel.saveUser()
                        } label: {
                            PrimaryButton(
                                title: "Save",
                                foregroundColor: .white,
                                backgroundColor: .red
                            )
                        }
                        .padding(Const.buttonsInsets)
                        Spacer()
                    }
                    
                }
            }
        }
        .navigationTitle("Settings")
        .padding(Const.viewInsets)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    appRouter.navigateBack()
                } label: {
                    Label("Back", systemImage: "arrow.left")
                }
                .tint(.red)
            }
        }
        .alert(item: $viewModel.alertItem) { alert in
            Alert(
                title: alert.title,
                message: alert.message,
                dismissButton: alert.dismissButton
            )
        }
    }
}

#Preview {
    SettingsView()
}
