//
//  SettingsEditImageView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import SwiftUI

struct SettingsEditImageView: View {
    
    @State var title: String
    @State var description: String
    @State var selectedImage: UIImage //Image shown on this screen
    @State var sourceType: UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
    @State var showImagePicker: Bool = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            
            Text(description)
            
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200, alignment: .center)
                .cornerRadius(12)
            
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Import".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.yellow)
                    .cornerRadius(12)
            }.tint(Color.MyTheme.purple)
                .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: $sourceType, imageSelected: $selectedImage)
            }
                
            Button {
                print("save")
            } label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.purple)
                    .cornerRadius(12)
            }.tint(Color.MyTheme.yellow)
               
            
            Spacer()
            
        }.navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
            .padding()
    }
}

struct SettingsEditImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsEditImageView(title: "Title", description: "Description", selectedImage: UIImage(named: "dog2")!)
        }
      
    }
}
