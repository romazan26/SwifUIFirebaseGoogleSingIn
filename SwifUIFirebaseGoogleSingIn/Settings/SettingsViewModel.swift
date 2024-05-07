//
//  SettingsViewModel.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 06.05.2024.
//

import Foundation


final class SettingsViewModel: ObservableObject {
    
    @Published var newPassword = ""
    @Published var newEmail = ""


    func logOut() throws {
        try AuthenticationManager.shared.singOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassowrd(email: email)
    }
    func updateEmail() async throws {
        try await AuthenticationManager.shared.updateEmail(email: newEmail)
        newEmail = ""
    }
    
    func updatePassword() async throws {
        try await AuthenticationManager.shared.updatePassword(password: newPassword)
        newPassword = ""
    }
}
