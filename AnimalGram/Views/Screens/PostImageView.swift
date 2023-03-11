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
    @Binding var videos: [URL]
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Button {
                    self.images = [self.images[0]]
                    self.videos = [self.videos[0]]
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .padding()
                }.tint(.primary)
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if let images = images {
                        ForEach(images[1...].indices, id: \.self) { index in
                            Image(uiImage: images[index])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200, alignment: .center)
                                .cornerRadius(20)
                                .clipped()
                        }
                    }
                   
                    if let videos = videos {
                        ForEach(videos[1...].indices, id: \.self) { index in
                           
                            VideoPlayer(player: AVPlayer(url: videos[index]))
                                .frame(minHeight: 200)
                            
                        }
                    }
                }
                
                
                
               
            }
            
            
            TextField(
                "",
                text: $captionText,
                prompt:
                    Text("Add your caption here...")
                    .foregroundColor(.gray)
            )
            .customTextField(background: Color.MyTheme.beige)
            .padding(.horizontal)
            
            Button {
//                    postViewModel.createPost(with: captionText, image: imageSelected, userID: authViewModel.userID!, imageURL: authViewModel.imageURL, userName: authViewModel.displayName, email: authViewModel.email)
            } label: {
                Text("Post Picture".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.purple)
                    .cornerRadius(12)
                    .padding(.horizontal)
            } .tint(Color.MyTheme.yellow)
                .alert(isPresented: $postViewModel.showAlert) {
                    Alert(
                        title: Text(postViewModel.alertMessage),
                        message: nil,
                        dismissButton: .default(Text("OK")) {
                            self.images = [self.images[0]]
                            self.videos = [self.videos[0]]
                            self.dismiss()
                        }
                    )
                }
        }.overlay {
            
            if postViewModel.isLoading {
                CustomProgressView()
//                ZStack {
//                    Color.primary.opacity(0.2).edgesIgnoringSafeArea(.all)
//                    ProgressView("Loading...")
//                        .progressViewStyle(
//                            CircularProgressViewStyle(tint: .cyan)
//                        )
//                }
                
            }
            
        }
    }
}

struct PostImageView_Previews: PreviewProvider {
    @State static var images = [UIImage(named: "dog3")!]
    @State static var videos = [URL(string: "https://bit.ly/swswift")!]
    static var previews: some View {
        PostImageView(images: $images, videos: $videos)
    }
}
