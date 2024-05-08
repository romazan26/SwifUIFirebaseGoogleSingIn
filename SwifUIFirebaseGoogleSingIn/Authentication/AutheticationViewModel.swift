//
//  AutheticationViewModel.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 08.05.2024.
//

import Foundation


@MainActor
final class AutheticationViewModel: ObservableObject{
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
       
        try await AuthenticationManager.shared.singInWhithGoogle(tokens: tokens)
    }
}
