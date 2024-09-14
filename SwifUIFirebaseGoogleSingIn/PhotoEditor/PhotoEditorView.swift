//
//  PhotoEditorView.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 14.09.2024.
//

import SwiftUI
import PhotosUI
import SwiftyCrop

struct PhotoEditorView: View {
    
    @StateObject var vm = PhotoEditorViewModel()
    
    
    
    var body: some View {
        VStack {
            
            Spacer()
            //MARK: - Image
            Image(uiImage: vm.selectedImage ?? UIImage(resource: .no))
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
            Spacer()

                
            
            if let selectedImage = vm.selectedImage{
                //MARK: - Crop button
                Button {
                    vm.showAlertMaskShape.toggle()
                } label: {
                    BackForButton(labelText: "Crop downloaded image")
                }
            }
            
            
            //MARK: - Selected input data
            HStack{
                //MARK: - Library button
                Button {
                    vm.sourceType = .photoLibrary
                    vm.showImagePicker.toggle()
                } label: {
                    BackForButton(labelText: "Photo Library")
                }
                //MARK: - Camers button
                Button {
                    vm.sourceType = .camera
                    vm.showImagePicker.toggle()
                } label: {
                    BackForButton(labelText: "Camera")
                }
            }
        }
        .navigationTitle("Photo editor")
        
        //MARK: - Action Sheet choose mask
        .actionSheet(isPresented: $vm.showAlertMaskShape, content: {
            ActionSheet(title: Text("Select mask shape"),
                        message: Text("Choose"), buttons: [
                            .default(Text("circle"), action: {
                                vm.maskShape = .circle
                                vm.showImageCropper.toggle()
                            }),
                            .default(Text("square"), action: {
                                vm.maskShape = .square
                                vm.showImageCropper.toggle()
                            }),
                            .default(Text("rectangle"), action: {
                                vm.maskShape = .rectangle
                                vm.showImageCropper.toggle()
                            })])
        })
        
        //MARK: - Sheet Image Picker
        .sheet(isPresented: $vm.showImagePicker, content: {
            ImagePicker(image: $vm.selectedImage, isShown: $vm.showImagePicker, sourceType: vm.sourceType)
        })
        
        //MARK: - Sheet Crop view
        .fullScreenCover(isPresented: $vm.showImageCropper) {
            if let selectedImage = vm.selectedImage {
                SwiftyCropView(
                    imageToCrop: selectedImage,
                    maskShape: vm.maskShape,
                    configuration: vm.configeration
                ) { croppedImage in
                    if let croppedImage = croppedImage{
                        vm.selectedImage = croppedImage
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Photo editor")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    guard let saveImage = vm.selectedImage else {return}
                    let imageSaver = ImageSaver()
                    imageSaver.writeToPhotoAlbum(image: saveImage)
                }, label: {
                    HStack {
                        Image(systemName: "externaldrive.fill.badge.checkmark")
                        Text("Save")
                    }.foregroundStyle(.red)
                })
            }
        })
    }
}

#Preview {
    NavigationView {
        PhotoEditorView()
    }
}
