//
//  PostImageView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import SwiftUI
import AVKit

struct PostImageView: View {
    
    @StateObject var postViewModel = PostViewModel()
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @State var captionText: String = ""
    @Binding var images: [UIImage]
    @Binding var imageSelected: UIImage?
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Button {
                    self.clearSelectedData()
                    self.dismiss()
                } label: {
                    ExitButtonView()
                        .frame(width: 32, height: 32)
                        .padding(.leading, 15)
                }.tint(.primary)
                
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    
                    
                    //photo from camera
                    if let imageSelected = imageSelected {
                        Image(uiImage: imageSelected)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 45,height: 250)
                            .cornerRadius(20)
                        
                        
                        
                    }
                    
                    if let images = images {
                        ForEach(images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width - 45,height: 250)
                                .cornerRadius(20)
                                .overlay {
                                    Button {
                                        self.images.remove(at: images.firstIndex(of: image)!)
                                    } label: {
                                        ExitButtonView()
                                            .frame(width: 32,height: 32)
                                        
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                    }.offset(y: -20)
                                }
                        }
                    }
                }.padding(.top, 20)
                    .onChange(of: images) {  newValue in
                        if newValue.count == 0 {
                            dismiss()
                        }
                    }
            }
            
            VStack(spacing: 10) {
                TextField(
                    "",
                    text: $captionText,
                    prompt:
                        Text("Add your caption here...")
                        .foregroundColor(.gray)
                )
                .customTextField(background: Color.MyTheme.beige)
                
                Button {
                    postViewModel.createPost(with: captionText, images: images, userID: authViewModel.userID!, imageURL: authViewModel.imageURL, userName: authViewModel.displayName, email: authViewModel.email)
                } label: {
                    Text("Post Pictures".uppercased())
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.MyTheme.purple)
                        .cornerRadius(12)
                } .tint(Color.MyTheme.yellow)
            }.padding(.all,20)
                .alert(isPresented: $postViewModel.showAlert) {
                    Alert(
                        title: Text(postViewModel.alertMessage),
                        message: nil,
                        dismissButton: .default(Text("OK")) {
                            self.clearSelectedData()
                            self.dismiss()
                        }
                    )
                }
        }
        
        .overlay {
            if postViewModel.isLoading {
                CustomProgressView()
            }
        }
    }
    
    func clearSelectedData() {
            self.images = [UIImage]()
            self.imageSelected = nil
    }
}

struct PostImageView_Previews: PreviewProvider {
    @State static var images: [UIImage] = [UIImage]()
    @State static var imageSelected: UIImage?
    
    static var previews: some View {
        PostImageView(images: $images, imageSelected: $imageSelected)
    }
}
