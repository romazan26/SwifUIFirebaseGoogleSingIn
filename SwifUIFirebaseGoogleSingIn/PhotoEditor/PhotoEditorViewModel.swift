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
import CoreImage
import CoreImage.CIFilterBuiltins


final class PhotoEditorViewModel: ObservableObject{
    
    //MARK: - Properties
    @Published var selectedImage: UIImage?
    @Published var showImagePicker = false
    @Published var sourceType: UIImagePickerController.SourceType = .camera
    @Published var maskShape = MaskShape.rectangle
    
    @Published var showAlertMaskShape = false
    @Published var showImageCropper = false
    
    @Published var intensity = 0.5
    @Published var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    //MARK: - Crop configuration
    let configeration = SwiftyCropConfiguration(maxMagnificationScale: 4.0,
                                                maskRadius: 130,
                                                cropImageCircular: true,
                                                rotateImage: true,
                                                zoomSensitivity: 3.0,
                                                rectAspectRatio: 4/3)
    
    //MARK: - CoreImageFunc
    func applyProcessing(){
        currentFilter.intensity = Float(intensity)
        
        guard let outputImage = currentFilter.outputImage else {return}
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiimage = UIImage(cgImage: cgimg)
            selectedImage = uiimage
        }
    }
    
    func loadImage(){
        guard let inputImage = selectedImage else {return}
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
}
