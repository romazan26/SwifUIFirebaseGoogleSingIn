//
//  BluButtonView.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 07.05.2024.
//

import SwiftUI

struct BluButtonView: View {
    let action: () -> Void
    let labelText: String
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(labelText)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        })
    }
}

#Preview {
    BluButtonView(action: {}, labelText: "button")
}
