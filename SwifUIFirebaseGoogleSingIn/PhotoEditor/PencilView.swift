//
//  PencilView.swift
//  SwifUIFirebaseGoogleSingIn
//
//  Created by Роман on 15.09.2024.
//

import SwiftUI
import PencilKit

struct PencilView: View {
    
    @StateObject var vm: PhotoEditorViewModel
    
    @State var image: UIImage
    
    var body: some View {
        ZStack {
            //MARK: - Pencil kit
            ZStack {
                GeometryReader{ proxy in
                    let size = proxy.frame(in: .global).size
                        ZStack {
                            PencilKitview(toolPicker: $vm.toolPicker, rect: size, pencilKitCanvasView: $vm.canvasView, imageData: $image)
                            
                            ForEach(vm.textBoxes) { box in
                                Text(vm.textBoxes[vm.currentIndex].id == box.id && vm.addNewbox ? "" : box.text)
                                    .font(.system(size: 30))
                                    .fontWeight(box.isBold ? .bold : .none)
                                    .foregroundStyle(box.textColor)
                                    .offset(box.offset)
                                    .gesture(DragGesture().onChanged({ (value) in
                                        let current = value.translation
                                        let lastOffest = box.lastOffSet
                                        let newTranslation = CGSize(width: lastOffest.width + current.width, height: lastOffest.height + current.height)
                                        vm.textBoxes[getIndex(textBox: box)].offset = newTranslation
                                    }).onEnded({ (value) in
                                        vm.textBoxes[getIndex(textBox: box)].lastOffSet = value.translation
                                    }))
                            }
                        }
                }
                
                    
            }
            
            //MARK: - Add text on image
            if vm.addNewbox{
                Color.black.opacity(0.75)
                    .ignoresSafeArea()
                
                TextField("Type here", text: $vm.textBoxes[vm.currentIndex].text)
                    .font(.system(size: 35))
                    .colorScheme(.dark)
                    .foregroundColor(vm.textBoxes[vm.currentIndex].textColor)
                    .padding()
                
                HStack{
                    Button(action: {
                        withAnimation {
                            vm.toolPicker.setVisible(true, forFirstResponder: vm.canvasView)
                            vm.canvasView.becomeFirstResponder()
                            vm.addNewbox = false
                            
                        }
                    }, label: {
                        Text("Add")
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                            .padding()
                    })
                    Spacer()
                    Button(action: {vm.cancelTextView()}, label: {
                        Text("Cancel")
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                            .padding()
                    })
                }
                .overlay(content: {
                    ColorPicker("", selection: $vm.textBoxes[vm.currentIndex].textColor)
                        .labelsHidden()
                })
                .frame(maxHeight: .infinity, alignment: .top)
            }
            
            
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                //MARK: - Save button
                Button("Save") {
                    //action
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                //MARK: - plus button
                Button(action: {
                    vm.textBoxes.append(TextBox())
                    vm.currentIndex = vm.textBoxes.count - 1
                    withAnimation {
                        vm.addNewbox.toggle()
                    }
                    vm.toolPicker.setVisible(false, forFirstResponder: vm.canvasView)
                    vm.canvasView.resignFirstResponder()
                }, label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("text")
                    }
                })
            }
    })
    }
    
    func getIndex(textBox: TextBox) -> Int{
        let index = vm.textBoxes.firstIndex { (box) -> Bool in
            return textBox.id == box.id
        } ?? 0
        
        return index
    }
}

#Preview {
    NavigationView {
        PencilView(vm: PhotoEditorViewModel(), image: UIImage(resource: .no))
    }
}

struct PencilKitview: UIViewRepresentable {
    
    @Binding var toolPicker: PKToolPicker
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
