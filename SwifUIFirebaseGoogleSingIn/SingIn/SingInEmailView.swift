//
//  SingInEmailView.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 06.05.2024.
//

import SwiftUI
 
struct SingInEmailView: View {
    
    @Binding var showSingInView: Bool
    @StateObject private var viewModel = SingEmailViewModel()
    @State var showProgress = false
    
    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            BluButtonView(action: {
                showProgress = true
                Task{
                    do {
                        try await viewModel.singIn()
                        showSingInView = false
                        showProgress = false
                    }catch {
                        print(error)
                    }
                }
            }, labelText: "SingIn")

            BluButtonView(action: {
                Task{
                    showProgress = true
                    do {
                        try await viewModel.createUser()
                        showSingInView = false
                        showProgress = false
                    }catch {
                        print(error)
                    }
                }
            }, labelText: "Create new user")

            if showProgress{ ProgressView() }
        }
        
        .padding()
        .navigationTitle("Sing with Email")
    }
}

#Preview {
    NavigationStack{
        SingInEmailView(showSingInView: .constant(false))
    }
    
}
