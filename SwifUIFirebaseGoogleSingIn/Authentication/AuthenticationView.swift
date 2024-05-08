//
//  AuthenticationView.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 06.05.2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthenticationView: View {
    
    @StateObject private var viewModel = AutheticationViewModel()
    @Binding var showSingInView: Bool
    @State var showProgress = false
    
    var body: some View {
        VStack{
            NavigationLink {
                SingInEmailView(showSingInView: $showSingInView)
            } label: {
                Text("Sing in whith email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal), action: {
                showProgress = true
                Task{
                    do{
                        try await viewModel.signInGoogle()
                        showSingInView = false
                        showProgress = false
                    }catch {
                        print(error)
                    }
                }
            })
            if showProgress{ ProgressView() }
            Spacer()
        }
        .padding()
        .navigationTitle("Sing In")
    }
}

#Preview {
    NavigationStack{
        AuthenticationView(showSingInView: .constant(false))
    }
    
}
