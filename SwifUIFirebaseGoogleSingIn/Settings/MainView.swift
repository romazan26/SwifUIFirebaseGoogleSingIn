//
//  SettingsView.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 06.05.2024.
//

import SwiftUI



struct MainView: View {
    @StateObject var viewModel = SettingsViewModel()
    @Binding var showSingInview: Bool
    

    var body: some View {
        VStack {
            Text("You have logged in")
                .font(.largeTitle)
                .bold()
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
            Divider().foregroundStyle(.red).padding(.vertical)
            
            if viewModel.authProviders.contains(.email){
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
                            print("Passwod update")
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
            
        }
        .onAppear(perform: {
            viewModel.loadAuthProviders()
        })
        .padding()
    }
}

#Preview {
    MainView(showSingInview: .constant(false))
}
