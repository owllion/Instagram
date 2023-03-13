//
//  ImageGridView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI
import FirebaseFirestore

struct ImageGridView: View {
    
    @EnvironmentObject var globalStateViewModel : GlobalStateViewModel
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    var posts: [Post]
   
    var body: some View {
        LazyVGrid(columns: Array(repeating:  GridItem(.flexible()), count: 3)) {
            ForEach(posts.indices, id: \.self) {
                    index in
                    NavigationLink {
                        FeedView(posts: posts, scrollIndex: index, title: "Posts")
                    } label: {
                        PostView(post: posts[index], showHeaderAndFooter: false)
                            
                    }.simultaneousGesture(TapGesture().onEnded {
                        globalStateViewModel.isFromSinglePost = true
                    })
                }

        }
    }
    
    
}

struct ImageGridView_Previews: PreviewProvider {
    @State static var posts: [Post] = [
                Post(postID: "",
                     userID: "",
                     displayName: "Tim Borton",
                     caption: "",
                     postImageURLs: [String](), userImageURL: "", email: "", likeCount: 10,
                     likedBy: [],
                     createdAt: Int(Date().timeIntervalSince1970)
                    )
                ]
    static var previews: some View {
        ImageGridView(posts: posts).previewLayout(.sizeThatFits)
    }
}
