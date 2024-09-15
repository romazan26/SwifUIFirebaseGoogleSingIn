//
//  TextBox.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 15.09.2024.
//

import SwiftUI
import PencilKit

struct TextBox: Identifiable{
    
    var id = UUID().uuidString
    var text: String = ""
    var isBold: Bool = false
    
    var offset: CGSize = .zero
    var lastOffSet: CGSize = .zero
    var textColor: Color = .black
}
