//
//  PhotoPicker.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/10.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var images: [UIImage]
    @Binding var videos: [URL]
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 5
        config.filter = .any(of: [.videos, .images])
        config.preferredAssetRepresentationMode = .current
        //if not add this, the import process is gonna take too much time
        
        
        let picker = PHPickerViewController(configuration: config)
        
        //tell the PHPickerViewController when somehting happens it should tell out coordinator
        //Notice taht Coordinator instance is accessible through the context parameter value of the method.
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
       
    }
    //SwiftUI call this automatically when an instance og PhotoPicker is created.
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    //NSObject -> lets Objective-c check for the functionality,and latter protocal is what actually provides it.
    //THe reason we use class: need to inherit from NSObject so that objective-c can query our coordinator to see what functionality it supports.
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        //照片選好-> 要去通知coordinator -> 必須得在Coordinator裡面能夠取到imageSelected -> 但直接把binding傳下來不好，反之可以跟coordinator說他的parent是誰 他就可以直接透過parent去修改值了
        var parent: PhotoPicker
        //
        init(parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            //dismiss picker
            picker.dismiss(animated: true)
            
            //Exit if no selection
            guard !results.isEmpty else { return }
            
            for res in results {
                
                let provider = res.itemProvider
                
                //簡單講：可透過type identifiers去確認是照片還是影片，而這個registerxxx他是個陣列，has the values of strings representing all types that data relates to.THe first obj is what we need.
                guard let typeIndextifier = provider.registeredTypeIdentifiers.first,
                      let utType = UTType(typeIndextifier) else { continue }
                
                if utType.conforms(to: .image) {
                    self.getPhotos(from: provider)
                } else if utType.conforms(to: .movie) {
                    self.getVideos(from: provider, typeIdentifier: typeIndextifier)
                }
            }
            
           
        }
        private func getPhotos(from itemProvider: NSItemProvider) {
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self.parent.images.append(image)
                        }
                    }
                }
            }
        }
        
        private func getVideos(from itemProvider: NSItemProvider, typeIdentifier: String) {
            itemProvider.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { url, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                guard let url = url else { return }
                print(FileManager.default.fileExists(atPath: url.path),"exist?")
                print(url,"exist url")
                
                DispatchQueue.main.async {
                    self.parent.videos.append(url)
                }
            }
        }
        
        
       
    }
}
