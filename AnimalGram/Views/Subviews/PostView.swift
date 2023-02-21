//
//  PostView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct PostView: View {
    
    @State var post: PostModel
    
    var showHeaderAndFooter: Bool
    //not showing header &footer version is for ImageGrid
    
    var body: some View {
        VStack(alignment: .center,
               spacing: 0) {
            
            //MARK: - HEADER
            if showHeaderAndFooter {
                HStack {
                    
                    //WE can use this is because we're in th navigationView
                    NavigationLink {
                        
                        
                        //isMyProfile = false => 因為這邊是貼文串，點進去當然是別人的
                        ProfileView(isMyProfile: false, profileDisplayName: post.username, profileUserID: post.userID)
                    } label: {
                        Image("dog1").resizable()
                            .scaledToFill().frame(width: 30,height: 30,alignment: .center).cornerRadius(15)
                        Text(post.username)
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }

                    
                    
                   
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                        .font(.headline)
                }.padding(.all, 6)
            }
            
            
            //MARK: - IMAGE
            Image("dog2")
                .resizable()
                .scaledToFit()
            
            //MARK: - FOOTER
            if showHeaderAndFooter {
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
}

struct PostView_Previews: PreviewProvider {
    static var post: PostModel = PostModel(postID: "", userID: "", username: "Tomothee", caption: "Test caption", dateCreate: Date(), likeCount: 0, likedByUser: false)
    
    static var previews: some View {
        PostView(post: post, showHeaderAndFooter: true).previewLayout(.sizeThatFits)
    }
}
