//
//  PostImageView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import SwiftUI

struct PostImageView: View {
    
    @StateObject var postViewModel = PostViewModel()
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @State var captionText: String = ""
    
    @Binding var imageSelected: UIImage
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .padding()
                }.tint(.primary)
                
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                
                Image(uiImage: imageSelected)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: .center)
                    .cornerRadius(20)
                    .clipped()
                
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
                    postViewModel.createPost(
                        with: captionText,
                        and: imageSelected,
                        by: authViewModel.userID!,
                        imageURL: authViewModel.imageURL,
                        named: authViewModel.displayName
                    )
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
                                self.dismiss()
                            }
                        )
                    }
            }
        }
    }
}

struct PostImageView_Previews: PreviewProvider {
    @State static var image = UIImage(named: "dog3")!
    
    static var previews: some View {
        PostImageView(imageSelected: $image)
    }
}
