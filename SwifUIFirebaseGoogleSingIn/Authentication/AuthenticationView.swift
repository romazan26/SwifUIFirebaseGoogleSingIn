//
//  AuthenticationView.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 06.05.2024.
//

import SwiftUI

struct AuthenticationView: View {
    @Binding var showSingInView: Bool
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
