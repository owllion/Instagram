//
//  ImageGridView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI
import FirebaseFirestore

struct ImageGridView: View {
    var posts: [Post]
    
    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ],
            alignment: .center,
            spacing: nil,
            pinnedViews: []) {
                ForEach(posts, id: \.postID) {
                    post in
                    NavigationLink {
                        FeedView(title:"Post")
                    } label: {
                        PostView(post: post, showHeaderAndFooter: false)
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
        ImageGridView(posts: posts).previewLayout(.sizeThatFits)
    }
}
