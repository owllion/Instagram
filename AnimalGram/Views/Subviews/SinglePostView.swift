//
//  SinglePostView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/28.
//

import SwiftUI

struct SinglePostView: View {
    @State var post: Post
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            PostView(post: post, showHeaderAndFooter: true)
        }.navigationTitle("Post")
            .navigationBarTitleDisplayMode(.large)
    }
}

//struct SinglePostView_Previews: PreviewProvider {
//    @State var postw: Post = Post(postID: "", userID: "", displayName: "Tomothee", caption: "Test caption", dateCreated: Int(Date().timeIntervalSince1970), postImageURL: "", likeCount: 0, likedByUser: false)
//    
//    static var previews: some View {
//     
//        SinglePostView(post: $postw)
//    }
//}
