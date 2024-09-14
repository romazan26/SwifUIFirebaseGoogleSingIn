//
//  PhotoEditorViewModel.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 14.09.2024.
//

import Foundation
import PhotosUI
import SwiftUI
import SwiftyCrop


final class PhotoEditorViewModel: ObservableObject{
    
    //MARK: - Properties
    @Published var selectedImage: UIImage?
    @Published var showImagePicker = false
    @Published var sourceType: UIImagePickerController.SourceType = .camera
    @Published var maskShape = MaskShape.rectangle
    
    @Published var showAlertMaskShape = false
    @Published var showImageCropper = false
    
    let configeration = SwiftyCropConfiguration(maxMagnificationScale: 4.0,
                                                maskRadius: 130,
                                                cropImageCircular: true,
                                                rotateImage: true,
                                                zoomSensitivity: 3.0,
                                                rectAspectRatio: 4/3)
}
