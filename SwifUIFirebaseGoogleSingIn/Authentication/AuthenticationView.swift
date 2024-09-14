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
            //MARK: - Logo image
            Image(systemName: "network.badge.shield.half.filled")
                .resizable()
                .frame(width: 150, height: 150)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5, x: 4, y: 4)
                .padding(.vertical)
            
            //MARK: - Sing in whith email
            NavigationLink {
                SingInEmailView(showSingInView: $showSingInView)
            } label: {
                Text("Sing in whith email")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background {
                        ZStack{
                            Color.gray
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .foregroundStyle(.white)
                                .blur(radius: 4)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: .main, radius: 20, x: 20, y: 20)
                    .shadow(color: .white, radius: 15, x: -5, y: -5)
            }
            
            //MARK: - Sing in whith Googl
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
        .background {
            Color.main.ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack{
        AuthenticationView(showSingInView: .constant(false))
    }
    
}
