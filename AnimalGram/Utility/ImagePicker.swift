//
//  ImagePicker.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import Foundation
import SwiftUI

//UIViewControllerRepresentable -> used to convert things from UIKit to the siwftUI format
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var sourceType: UIImagePickerController.SourceType
    //使用者可以自行選擇要拍照還是從相簿import，所以用變數存起來變成dynamic

    @Binding var imageSelected: UIImage
    //參數傳入
    
    @Environment(\.dismiss) var dismiss
    //every screen has access to this variable,coz it's environment variable(like global variable?)
    //Purpose: dismiss the target
    //p.s 也可寫@Environment(\.presentationMode) var presentationMode
    //p.s 貌似(\.xxx)要和var xxx是一樣的名稱
    
    
    
    //this method is called as soon as the imagePicker is initialized and it's used to make some controller or screen
    func makeUIViewController(context: Context) -> UIImagePickerController {
        //Context等同於 UIViewControllerRepresentableContext<ImagePicker>
        
        let picker = UIImagePickerController() //和UIKit一樣
        
        //UIKit -> picker.delegate = self,但這邊self可不是view所以才要另外去做設定
        //而這邊的coordinator大概也就等於是self,也就是這個struct ImagePicker 本身啦
        picker.delegate = context.coordinator
        //have to make a custom coordinator that will conform to the imagePicker controller and delegate
        
        picker.sourceType = sourceType
        picker.allowsEditing = true
        return picker
    }
    
    //do not need this
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(parent: self)
        //self is equal to ImagePicker which is this struct ImagePicker
    }
    
    
    class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var parent: ImagePicker
        //we need our parent to dismiss the screen and do other things
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        
        
        //method comes from UIImagePickerControllerDelegate
        /*
            Everytime users pick some media within the imagePicker,this fn gets called after they pick it.
            And we can use the info variable to access that media.
            (總之就是選擇照片之後就會被觸發)
         */
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            //try to get edited,if you don't,then get original.
            /*
             as? UIImage:
                 Try to convert that data inot UIImage
                    bacause the values in the dictionary are of type Any
                    they could be videos or photos.
                    But we only need UIImages for our purposes.
            */
            if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
                //select the image for our app
                parent.imageSelected = image
                
                print("被呼叫 parent imageSelected")
                
                //dismiss the screen ,both needs parent(which is ImagePicker)
                parent.dismiss()
                //or parent.presentationMode.wrappedValue.dismiss()
                
            }
            
            
        }
        
    }
    
}
