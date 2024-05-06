//
//  SettingsViewModel.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 06.05.2024.
//

import Foundation


final class SettingsViewModel: ObservableObject {


    func logOut() throws {
        try AuthenticationManager.shared.singOut()
    }
}
