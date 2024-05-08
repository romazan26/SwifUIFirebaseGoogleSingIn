//
//  SignInGoogleHelper.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 08.05.2024.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInresultModel{
    let idToken: String
    let accessToken: String
}

final class SignInGoogleHelper {
    
    @MainActor
    func signIn() async throws -> GoogleSignInresultModel {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        let gidSinInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        
        guard let idToken = gidSinInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken = gidSinInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInresultModel(idToken: idToken, accessToken: accessToken)
        
        return tokens
    }
}
