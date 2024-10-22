//
//  MediaPickerScreen.swift
//  FarmFoster
//
//  Created by Roshan Chemjong on 24/04/2024.
//

import SwiftUI
import PhotosUI

enum ImageItem {
    case image(UIImage)
    
    var unwrap: UIImage {
        switch self {
        case .image(let image):
            return image
        }
    }
}

enum MediaPickerRoute: Hashable, Identifiable {
    var id: Self { self } // Self = type of instance, self = case of instance type

    case camera
    case gallery
//    case editor([PHMediaItem])

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct MediaPickerScreen: View {
    @State private var showMediapickersheet = false
    @State private var presetableRoute: MediaPickerRoute?
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var multipleSelectedImage: [UIImage] = []
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel: MediaPickerViewModel
    @State var singlePicker: Bool?
    
    var col: [GridItem] = [GridItem(.flexible(minimum: 100, maximum: 100), spacing: 15, alignment: .leading),
                           GridItem(.flexible(minimum: 100, maximum: 100), spacing: 15, alignment: .leading)]
    
    init(viewModel: MediaPickerViewModel, singlePicker: Bool? = true) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.singlePicker = singlePicker
    }
    var body: some View {
        VStack {
            mainContainer
                .padding()
//                .navigationTitle("Media Picker")
                .showMediaPickerActionSheet($showMediapickersheet) {
                    presetableRoute = .gallery
                    //                showImagePicker = true
                } openCamera: {
                    presetableRoute = .camera
                }
                .fullScreenCover(item: $presetableRoute) { route in
                    switch route {
                    case .gallery:
                        if let singlePicker = singlePicker, singlePicker == true {
                            MediaPicker(sourceType: .photoLibrary, selectedImage: self.$selectedImage, viewModel: viewModel )
                        } else {
                            MultipleMediaPicker(selectedImages: self.$multipleSelectedImage, selectionLimit: 5, viewModel: viewModel)
                        }
                    case .camera:
                        EmptyView()
                    }
                }
        }
        .defaultNavigationBack(title: componentsList.mediaPicker.key){
                dismiss()
            }
    }
    
    @ViewBuilder
    private var mainContainer: some View {
        if !viewModel.selectedImgae.isEmpty {
            ScrollView(.horizontal) {
            LazyHGrid(rows: col) {
                ForEach(viewModel.selectedImgae.indices, id: \.self) { index in
                    let image = viewModel.selectedImgae[index].unwrap
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
            
            Button(action: {
                showMediapickersheet = true
            }, label: {
                Text("Add media")
            })
            
        } else {
            Button(action: {
                showMediapickersheet = true
            }, label: {
                Text("Add media")
            })
        }
    }
}

struct MediaPicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType
    @Binding  var selectedImage: UIImage?
    @ObservedObject var viewModel: MediaPickerViewModel
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
       }
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
       var parent: MediaPicker

       init(parent: MediaPicker) {
           self.parent = parent
       }

       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let image = info[.originalImage] as? UIImage {
               parent.selectedImage = image
               parent.viewModel.selectedImgae.append(.image(image))
           }
           picker.dismiss(animated: true)
       }
    
        

       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true)
       }
   }


extension View {
    @ViewBuilder
    func showMediaPickerActionSheet(_ showMediaPicker: Binding<Bool>,
                                    displayGallery: @escaping ()-> Void,
                                    openCamera: @escaping ()-> Void) -> some View
    {
        actionSheet(isPresented: showMediaPicker) {
            ActionSheet(title: Text("Select"), buttons: [.default(Text("Camera"), action: openCamera),
                                                         .default(Text("Gallery"), action: displayGallery),
                                                         .cancel()])
        }
    }
    
    func defaultNavigationBack(title: String? = nil, backAction: @escaping () -> Void) -> some View {
        navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                   Button(action: {
                       backAction()
                   }, label: {
                       Image(systemName: "chevron.backward")
                           .foregroundColor(Color.black)
                   })
                }
            })
            .navigationTitle(title ?? "")
        
    }
}

struct MultipleMediaPicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage] // To store selected images
    @State var selectionLimit: Int
    @ObservedObject var viewModel: MediaPickerViewModel

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = selectionLimit // Allow selecting up to 5 images
        config.filter = .images // Only allow selecting images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator // Set picker delegate
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // Update UI if needed
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: MultipleMediaPicker

        init(parent: MultipleMediaPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.selectedImages = []

            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                            result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                                if let image = image as? UIImage {
                                    DispatchQueue.main.async {
                                        self.parent.selectedImages.append(image)
                                        self.parent.viewModel.selectedImgae.append(.image(image))
                                        picker.dismiss(animated: true)
                                    }
                                }
                            }
                        }
            }
            
            func pickerDidCancel(_ picker: PHPickerViewController) {
                picker.dismiss(animated: true)
            }
        }
    }
}

#Preview {
    MediaPickerScreen(viewModel: MediaPickerViewModel())
}
