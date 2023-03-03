//
//  SettingsEditImageView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import SwiftUI
import URLImage


struct SettingsEditImageView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var settingsEditTextViewModel = SettingsEditTextViewModel()
    @Environment(\.dismiss) var dismiss

    @State var imageSelected: UIImage = UIImage(named: "dog3")!
    
    @State var hasSelectedImg: Bool = false
    
    @State var title: String
    @State var description: String
    @State var imgURL: String
    @State var sourceType: UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
    @State var showImagePicker: Bool = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            
            Text(description)
            if hasSelectedImg {
                Image(uiImage: imageSelected)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: .center)
                    .cornerRadius(12)
                    
            } else {
                URLImage(
                    url: URL(string: imgURL)!,
                    failure: { error, retry in
                        VStack {
                            Text(error.localizedDescription)
                        }
                    },
                    content: { image in
                         image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200, alignment: .center)
                            .cornerRadius(12)
                     })

            }
            
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
                ImagePicker(sourceType: $sourceType, imageSelected: $imageSelected)
            }.onChange(of: imageSelected, perform: { _ in
                self.hasSelectedImg = true
            })
                
            Button {
                settingsEditTextViewModel.uploadUserAvatar(userID: authViewModel.userID!, imageSelected: imageSelected) {
                    url, error in
                        
                    if let error = error {
                        self.settingsEditTextViewModel.handleAlert(error, msg: nil)
                        return
                    }
                    self.authViewModel.imageURL = url!
                    
                    //update db
                    Task {
                        await self.settingsEditTextViewModel.updateUserAvatar(email: self.authViewModel.email, url: url!)
                    }
                    
                    
                    settingsEditTextViewModel.handleSuccess(msg: "Successfully change your avatar")
                }
                
                
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
            .alert(isPresented: $settingsEditTextViewModel.showAlert) {
                return Alert(title: Text("Saved!"), message: Text(settingsEditTextViewModel.alertMessage), dismissButton: .default(Text("OK")) {
                    self.dismiss()
                }
                )
            }
    }
}

struct SettingsEditImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsEditImageView(title: "Title", description: "Description", imgURL: "")
        }
      
    }
}
