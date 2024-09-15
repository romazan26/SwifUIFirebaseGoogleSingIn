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
            VStack {
                Text("Original")
                Image(uiImage: vm.selectedImage ?? UIImage(resource: .no))
                    .resizable()
                    .scaledToFit()
                .cornerRadius(10)
            }
            
            VStack {
                Text("Modified")
                Image(uiImage: vm.modifiedImage ?? UIImage(resource: .no))
                    .resizable()
                    .scaledToFit()
                .cornerRadius(10)
            }
            
            Spacer()
            
            //MARK: - if we have image
            if let selectedImage = vm.selectedImage{
                VStack {
                    HStack{
                        Text("Intensity")
                        Slider(value: $vm.intensity)
                            .onChange(of: vm.intensity) {
                                vm.applyProcessing()
                            }
                    }
                    HStack{
                        //MARK: - Crop button
                        Button {
                            vm.showAlertMaskShape.toggle()
                        } label: {
                            BackForButton(labelText: "Crop")
                        }
                        //MARK: - Effect button
                        Button {
                            vm.showChooseFilter.toggle()
                        } label: {
                            BackForButton(labelText: "Effect")
                        }
                        //MARK: - Pencil button
                        NavigationLink {
                            PencilView(vm: vm, image: vm.modifiedImage ?? UIImage(resource: .no))
                        } label: {
                            BackForButton(labelText: "Pencil")
                        }
                    }
                }
                .padding()
                .background {
                    Color.black.opacity(0.2)
                        .cornerRadius(20)
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
        .onChange(of: vm.selectedImage, {
            vm.loadImage()
        })
        
        //MARK: - Confirmation Dialog choose filter
        .confirmationDialog("Selected afilter", isPresented: $vm.showChooseFilter){
            Button("Crystallize") {vm.setFilter(.crystallize())}
            Button("Edges") {vm.setFilter(.edges())}
            Button("GaussianBlur") {vm.setFilter(.gaussianBlur())}
            Button("Pixellate") {vm.setFilter(.pixellate())}
            Button("sepiaTone") {vm.setFilter(.sepiaTone())}
            Button("UnsharpMask") {vm.setFilter(.unsharpMask())}
            Button("Cancel", role: .cancel) {}
        }
        
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
            if let selectedImage = vm.modifiedImage {
                SwiftyCropView(
                    imageToCrop: selectedImage,
                    maskShape: vm.maskShape,
                    configuration: vm.configeration
                ) { croppedImage in
                    if let croppedImage = croppedImage{
                        vm.modifiedImage = croppedImage
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Photo editor")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                //MARK: - Save button
                Button(action: {
                    guard let saveImage = vm.modifiedImage else {return}
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
