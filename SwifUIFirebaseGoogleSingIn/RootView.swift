//
//  RootView.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 06.05.2024.
//

import SwiftUI

struct RootView: View {
    @State private var showSingInView = false
    
    var body: some View {
        ZStack{
            if !showSingInView {
                NavigationStack{
                    MainView(showSingInview: $showSingInView)
                }
            }
        }
            .onAppear(perform: {
                let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                showSingInView = authUser == nil
            })
            .fullScreenCover(isPresented: $showSingInView, content: {
                NavigationStack{
                    AuthenticationView(showSingInView: $showSingInView)
                }
            })
        
    }
}

#Preview {
    RootView()
}
