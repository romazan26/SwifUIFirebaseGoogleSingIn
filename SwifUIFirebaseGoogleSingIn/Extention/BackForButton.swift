//
//  BackForButton.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 14.09.2024.
//

import SwiftUI

struct BackForButton: View {
    var labelText = ""
    var body: some View {
        Text(labelText)
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .foregroundStyle(.black)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background {
                ZStack{
                    Color.main
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundStyle(.white)
                        .blur(radius: 4)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: .main, radius: 20, x: 20, y: 20)
            .shadow(color: .white, radius: 15, x: -5, y: -5)
    }
}

#Preview {
    BackForButton()
}
