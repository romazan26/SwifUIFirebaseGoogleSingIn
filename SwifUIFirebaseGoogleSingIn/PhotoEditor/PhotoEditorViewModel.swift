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
import PencilKit


final class PhotoEditorViewModel: ObservableObject{
    
    //MARK: - Properties
    @Published var selectedImage: UIImage?
    @Published var modifiedImage: UIImage?
    @Published var showImagePicker = false
    @Published var sourceType: UIImagePickerController.SourceType = .camera
    @Published var maskShape = MaskShape.rectangle
    
    @Published var showAlertMaskShape = false
    @Published var showImageCropper = false
    @Published var showChooseFilter = false
    
    @Published var intensity = 0.5
    @Published var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @Published var canvasView = PKCanvasView()
    @Published var toolPicker = PKToolPicker()
    @Published var textBoxes: [TextBox] = []
    @Published var addNewbox = false
    @Published var currentIndex : Int = 0
    @Published var rect: CGRect = .zero
    
    
    //MARK: - Add text on image func
    func cancelTextView(){
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
        withAnimation {
            addNewbox = false
        }
        textBoxes.removeLast()
    }
    func saveImagePencli(){
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1)
        canvasView.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        let generatingImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let image = generatingImage{
            modifiedImage = image
            print("succes...")
        }
    }
    
    //MARK: - Crop configuration
    let configeration = SwiftyCropConfiguration(maxMagnificationScale: 4.0,
                                                maskRadius: 130,
                                                cropImageCircular: true,
                                                rotateImage: true,
                                                zoomSensitivity: 3.0,
                                                rectAspectRatio: 4/3)
    
    //MARK: - CoreImageFunc
    func applyProcessing(){
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(intensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(intensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey){
            currentFilter.setValue(intensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else {return}
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiimage = UIImage(cgImage: cgimg)
            modifiedImage = uiimage
        }
    }
    
    func setFilter(_ filter: CIFilter){
        currentFilter = filter
        loadImage()
    }
    
    func loadImage(){
        guard let inputImage = selectedImage else {return}
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
}
