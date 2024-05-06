//
//  SettingsView.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 06.05.2024.
//

import SwiftUI



struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    @Binding var showSingInview: Bool

    var body: some View {
        List {
            Button("log out") {
                Task {
                    do {
                        try viewModel.logOut()
                        showSingInview = true
                    }catch {
                      print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView(showSingInview: .constant(false))
}
