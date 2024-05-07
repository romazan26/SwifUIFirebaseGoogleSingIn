//
//  SingEmailViewModel.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 06.05.2024.
//

import Foundation

final class SingEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func createUser() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
                try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func singIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
                try await AuthenticationManager.shared.singIn(email: email, password: password)
    }
    
}
