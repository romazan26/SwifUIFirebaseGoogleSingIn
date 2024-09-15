//
//  SettingsView.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 06.05.2024.
//

import SwiftUI



struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @Binding var showSingInview: Bool
    

    var body: some View {
        ZStack {
            //MARK: - Background
            Color.main.ignoresSafeArea()
            
            //MARK: - Main stack
            VStack(spacing: 20) {
                Spacer()
                Text("You have logged in")
                    .font(.largeTitle)
                    .bold()
                
                //MARK: - Log out button
                CustomShadowButtonView(action: {
                    Task {
                        do {
                            try viewModel.logOut()
                            showSingInview = true
                        }catch {
                          print(error)
                        }
                    }
                }, labelText: "Log out")
                NavigationLink {
                    PhotoEditorView()
                } label: {
                    BackForButton(labelText: "Photo Editor")
                }

                Spacer()
                
                //MARK: - if log in whith email
                ScrollView{
                    VStack{
                        if !viewModel.authProviders.contains(.email){
                            Divider().foregroundStyle(.red).padding(.vertical)
                            Text("Account settings")
                                .font(.title)
                                .bold()
                            //MARK: - password reset button
                            CustomShadowButtonView(action: {
                                Task {
                                    do {
                                        try await viewModel.resetPassword()
                                        print("password reset")
                                    }catch {
                                        print(error)
                                    }
                                }
                            }, labelText: "Password reset")
                            
                            //MARK: - Update Password group
                            SecureField("new password", text: $viewModel.newPassword)
                                .textFieldStyle(.roundedBorder)
                            CustomShadowButtonView(action: {
                                
                                Task {
                                    do {
                                        try await viewModel.updatePassword()
                                        print("Password update")
                                    }catch {
                                        print(error)
                                    }
                                }
                            }, labelText: "Passwod update")
                            
                            //MARK: - Update Email group
                            TextField("new email", text: $viewModel.newEmail)
                                .textFieldStyle(.roundedBorder)
                            CustomShadowButtonView(action: {
                                
                                Task {
                                    do {
                                        try await viewModel.updateEmail()
                                        print("email update")
                                    }catch {
                                        print(error)
                                    }
                                }
                            }, labelText: "Email update")
                            
                        }
                    }.padding(.horizontal,50)
                }
                
            }
            .onAppear(perform: {
                viewModel.loadAuthProviders()
            })
        .padding()
        }
    }
}

#Preview {
    MainView(showSingInview: .constant(false))
}
