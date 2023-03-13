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
//    @State var images: [UIImage] = [UIImage(imageLiteralResourceName: "logo")]
//    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var images: [UIImage] = [UIImage]()
    @State var imageSelected: UIImage?
    
    @State var showImagePicker: Bool = false
    @State var showPHPicker: Bool = false
    @State var showPostImageView: Bool = false
    @State var sourceType:UIImagePickerController.SourceType = .camera
    
    var body: some View {
        ZStack {
            //MARK: - VSTack
            VStack {
                
                Button {
                    sourceType = UIImagePickerController.SourceType.camera
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
                    //import using PHPickerController
                    showPHPicker.toggle()
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
                if imageSelected != nil {
                    segueToPostImageView()
                }
            } content: {
                ImagePicker(sourceType: $sourceType, imageSelected: $imageSelected )
                        .onChange(of: imageSelected) {
                            newValue in
                            print("imageSelected new value")
                            

                        }
           
                
            }
            .sheet(isPresented: $showPHPicker) {
                if images.count > 0 {
                    segueToPostImageView()
                }
            } content: {
                PhotoPicker(images: $images)
                    .onChange(of: images.count) { newValue in
                        print(newValue,"this is newValue")
                        print(showPostImageView,"this is showPostImagevie")
                       // self.segueToPostImageView()

                    }
            }

            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100,height: 100,alignment: .center)
                .shadow(radius: 12)
                .fullScreenCover(isPresented: $showPostImageView) {
                    PostImageView(images: $images, imageSelected: $imageSelected)
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
