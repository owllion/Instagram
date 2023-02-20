//
//  PostView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct PostView: View {
    
    @State var post: PostModel
    
    var body: some View {
        VStack(alignment: .center,
               spacing: 0) {
            
            //MARK: - HEADER
            HStack {
                Image("dog1").resizable()
                    .scaledToFill().frame(width: 30,height: 30,alignment: .center).cornerRadius(15)
                Text(post.username)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .font(.headline)
            }.padding(.all, 6)
            
            //MARK: - IMAGE
            Image("dog2")
                .resizable()
                .scaledToFit()
            
            //MARK: - FOOTER
            HStack(alignment: .center, spacing: 20) {
                Image(systemName: "heart").font(.title3)
                
                //MARK: - COMMENTS ICON
                NavigationLink(
                    destination: CommentsView()) {
                        Image(systemName: "bubble.middle.bottom").foregroundColor(.primary)
                }
                Image(systemName: "paperplane").font(.title3)
                
                Spacer()
            }.padding(.all,10)
            if let caption = post.caption {
                HStack {
                    Text(caption)
                    Spacer(minLength: 0)
                    //when caption == entire screen,then len== 0; otherwise certain amount.
                }.padding(.all,10)
            }
            
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var post: PostModel = PostModel(postID: "", userID: "", username: "Tomothee", caption: "Test caption", dateCreate: Date(), likeCount: 0, likedByUser: false)
    
    static var previews: some View {
        PostView(post: post).previewLayout(.sizeThatFits)
    }
}
