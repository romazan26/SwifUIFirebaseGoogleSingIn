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
        ZStack {
            GeometryReader{ proxy -> AnyView in
                let size = proxy.frame(in: .global).size
                
                return AnyView(
                    ZStack {
                        PencilKitview(rect: size, pencilKitCanvasView: $canvasView, imageData: $image)
                    }
                )
            }
            
                
        }
    }
}

#Preview {
    PencilView()
}

struct PencilKitview: UIViewRepresentable {
    
    let toolPicker = PKToolPicker()
    typealias UIViewType = PKCanvasView
    var rect: CGSize
    
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
        
        let imageView = UIImageView(image: imageData)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        let subView = pencilKitCanvasView.subviews[0]
        subView.addSubview(imageView)
        subView.sendSubviewToBack(imageView)
        
        return pencilKitCanvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
    
    
}
