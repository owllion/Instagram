//
//  UploadView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI
import UIKit

struct UploadView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var images: [UIImage] = [UIImage(imageLiteralResourceName: "logo")]
    @State var showImagePicker: Bool = false
    @State var showPostImageView: Bool = false
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
            }
            .sheet(isPresented: $showImagePicker) {
                segueToPostImageView()
            } content: {
//                ImagePicker(sourceType: $sourceType, imageSelected: $imageSelected)
//                    .tint(colorScheme == .light ? Color.MyTheme.purple : Color.MyTheme.yellow )
                PhotoPicker(images: $images,videos: $videos)
            }

            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100,height: 100,alignment: .center)
                .shadow(radius: 12)
                .fullScreenCover(isPresented: $showPostImageView) {
                    PostImageView(images: $images)
                        .preferredColorScheme(colorScheme)
                }

        }.edgesIgnoringSafeArea(.top)
        //top is bacause we have tab at the bottom,so no need to ignore the bottom
    }
    
    //MARK: - segueToPostImageVie
    func segueToPostImageView() {
        //need to delay the appear timing,that seems more reasonable
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            showPostImageView.toggle()
        }
        
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
