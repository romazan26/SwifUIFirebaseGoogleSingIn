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
        ZStack {
            Color.main.ignoresSafeArea()
            VStack {
                //MARK: - Logo image
                Image(systemName: "envelope.fill")
                    .resizable()
                    .frame(width: 180, height: 150)
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5, x: 4, y: 4)
                    .padding(.vertical)
                //MARK: - Group of TextField
                VStack{
                    TextField("Email...", text: $viewModel.email)
                        .padding()
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
                    SecureField("Password...", text: $viewModel.password)
                        .padding()
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
                
                //MARK: - Group of button
                VStack{
                    CustomShadowButtonView(action: {
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
                    
                    
                    CustomShadowButtonView(action: {
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
                }
                .padding(.top, 30)
                
                //MARK: - ProgressViiew
                if showProgress{ ProgressView() }
                Spacer()
            }
            .padding()
        .navigationTitle("Sing with Email")
        }
    }
}

#Preview {
    NavigationStack{
        SingInEmailView(showSingInView: .constant(false))
    }
    
}
