//
//  ImageGridView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

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
                ForEach(posts, id: \.self) {
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
//
//struct ImageGridView_Previews: PreviewProvider {
//    static let posts = [
//                Post(postID: "",
//                     userID: "",
//                     displayName: "Tim Borton",
//                     caption: "",
//                     dateCreated: Int(Date().timeIntervalSince1970),
//                     postImageURL: "", likeCount: 10,
//                     likedByUser: false
//                    )
//                ]
//
//
//
////    static var previews: some View {
////        ImageGridView(posts: $posts).previewLayout(.sizeThatFits)
////    }
//}
