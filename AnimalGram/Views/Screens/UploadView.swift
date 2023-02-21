//
//  UploadView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI
import UIKit

struct UploadView: View {
    
    @State var showImagePicker: Bool = false
    @State var imageSelected: UIImage = UIImage(imageLiteralResourceName: "logo")
    @State var sourceType:UIImagePickerController.SourceType = .camera
    
    var body: some View {
        ZStack {
            //MARK: - VSTack
            VStack {
                
                Button {
                    sourceType = UIImagePickerController.SourceType.camera
                    //設定好之後就顯示imagePicker screen
                    showImagePicker.toggle()
                } label: {
                    Text("Take photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.MyTheme.yellow)
                }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                ).background(Color.MyTheme.purple)
                
                Button {
                    sourceType = UIImagePickerController.SourceType.photoLibrary
                    showImagePicker.toggle()
                } label: {
                    Text("import photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.MyTheme.purple)
                }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                ).background(Color.MyTheme.yellow)
            }.sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: $sourceType, imageSelected: $imageSelected)
            }
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100,height: 100,alignment: .center)
                .shadow(radius: 12)
        }.edgesIgnoringSafeArea(.top)
        //top is bacause we have tab at the bottom,so no need to ignore the bottom
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
