//
//  ImageGridView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI
import FirebaseFirestore

struct ImageGridView: View {
    
    @ObservedObject var browseViewModel = BrowseViewModel()
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    var shuffledPosts:[Post] = [Post]()
    var posts: [Post]
    var from: String
    var userID: String? //for getting userPosts
    
    var body: some View {
        LazyVGrid(columns: Array(repeating:  GridItem(.flexible()), count: 3)) {
            ForEach(posts.indices, id: \.self) {
                    index in
                    NavigationLink {
                        FeedView(posts: posts, scrollIndex: index, title:"Post", from: "" )
                    } label: {
                        PostView(post: posts[index], showHeaderAndFooter: false)
                            
                    }
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
                     postImageURL: "", userImageURL: "", email: "", likeCount: 10,
                     likedBy: [],
                     createdAt: Int(Date().timeIntervalSince1970)
                    )
                ]
    static var previews: some View {
        ImageGridView(posts: posts, from: "browse").previewLayout(.sizeThatFits)
    }
}
