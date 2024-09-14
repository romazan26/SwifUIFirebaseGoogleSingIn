//
//  CropView.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 14.09.2024.
//

import SwiftUI
import SwiftyCrop

struct CropView: View {
    @State private var showImageCropper: Bool = false
    @State private var selectedImage: UIImage?

        var body: some View {
            VStack {
                
                if let selectedImage = selectedImage{
                    Image(uiImage: selectedImage)
                }
                 Button("Crop downloaded image") {
                     selectedImage = UIImage(resource: .no)
                     showImageCropper.toggle()
                 }

            }
            .fullScreenCover(isPresented: $showImageCropper) {
                if let selectedImage = selectedImage {
                    SwiftyCropView(
                        imageToCrop: selectedImage,
                        maskShape: .square
                    ) { croppedImage in
                        if let croppedImage = croppedImage{
                            self.selectedImage = croppedImage
                        }
                    }
                }
            }
        }
}

#Preview {
    CropView()
}
