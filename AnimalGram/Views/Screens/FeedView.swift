//
//  FeedView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct FeedView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @ObservedObject var feedViewModel = FeedViewModel()
    @ObservedObject var profileViewModel = ProfileViewModel()
    
   
    
    @State var displayPosts: [Post] = [Post]()

    var posts: [Post]
    var scrollIndex: Int?
    var title: String
    
    var postID: String?
    var userID: String? //get userPosts
    
    var body: some View {
        ScrollViewReader { scrollView in 
            ScrollView (.vertical, showsIndicators: false) {
                LazyVStack {
                    ForEach(posts.indices, id: \.self) { index in
                        PostView(post: posts[index], showHeaderAndFooter: true).id(index)
                    }
                }
                
            }.navigationTitle(title)
                .navigationBarTitleDisplayMode(.large)
                .onAppear {
                    if let scrollIndex = self.scrollIndex {
                        withAnimation(.easeIn(duration: 0.8)) {
                            scrollView.scrollTo(scrollIndex)
                        }
                    }
                }
                
        }
       
    }
}

struct FeedView_Previews: PreviewProvider {
    @State static var posts = [Post(postID: "", userID: "", displayName: "", caption: "", postImageURL: "", userImageURL: "", email: "", likeCount: 9, likedBy: [], createdAt: Int(Date().timeIntervalSince1970))]
    static var previews: some View {
        NavigationView {
            FeedView(posts: posts, scrollIndex: 5, title: "")

        }
    }
}
