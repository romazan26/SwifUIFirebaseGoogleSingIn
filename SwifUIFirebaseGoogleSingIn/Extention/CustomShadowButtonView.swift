//
//  BluButtonView.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 07.05.2024.
//

import SwiftUI

struct CustomShadowButtonView: View {
    let action: () -> Void
    let labelText: String
    var body: some View {
        Button(action: {
            action()
        }, label: {
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
                .shadow(color: .white, radius: 20, x: -20, y: -20)
                
        })
    }
}

#Preview {
    CustomShadowButtonView(action: {}, labelText: "button")
        .padding()
        .background {
            Color.main
                .frame(height: 200)
        }
}
