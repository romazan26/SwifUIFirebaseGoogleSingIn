//
//  PencilView.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 15.09.2024.
//

import SwiftUI
import PencilKit

struct PencilView: View {
    @State var canvasView = PKCanvasView()
    
    @State var image: UIImage = .no
    
    var body: some View {
            PencilKitview(pencilKitCanvasView: $canvasView, imageData: $image)
                .frame(width: 500, height: 500)
    }
}

#Preview {
    PencilView()
}

struct PencilKitview: UIViewRepresentable {
    
    let toolPicker = PKToolPicker()
    typealias UIViewType = PKCanvasView
    
    @Binding var pencilKitCanvasView: PKCanvasView
    @Binding var imageData: UIImage
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        pencilKitCanvasView.drawingPolicy = PKCanvasViewDrawingPolicy.anyInput
        
        toolPicker.addObserver(pencilKitCanvasView)
        toolPicker.setVisible(true, forFirstResponder: pencilKitCanvasView)
        pencilKitCanvasView.becomeFirstResponder()
        pencilKitCanvasView.drawingPolicy = .anyInput
        pencilKitCanvasView.isOpaque = false
        pencilKitCanvasView.backgroundColor = .clear
        
        return pencilKitCanvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        let imageView = UIImageView(image: imageData)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        let subView = pencilKitCanvasView.subviews[0]
        subView.addSubview(imageView)
        subView.sendSubviewToBack(imageView)
    }
    
    
}
