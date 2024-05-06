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
    
    func singIn() {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        Task{
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("success")
                print(returnedUserData)
            }catch {
                print("Error: \(error)")
            }
        }
    }
    
}
