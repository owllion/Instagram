//
//  FeedView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct FeedView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var globalStateViewModel: GlobalStateViewModel
    @ObservedObject var feedViewModel = FeedViewModel()
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    var posts: [Post]
    var scrollIndex: Int?
    var title: String
    
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
//                    print(self.globalStateViewModel.isFromSinglePost,"from sigle FeedView")
                    if let scrollIndex = self.scrollIndex, globalStateViewModel.isFromSinglePost {
                        withAnimation(.easeIn(duration: 0.8)) {
                            scrollView.scrollTo(scrollIndex)
                        }
                    }
//                    if !globalStateViewModel.isFromSinglePost {
//                        feedViewModel.getPosts()
//                       
//                    }
                    
                    
                }
                
        }
       
    }
}

struct FeedView_Previews: PreviewProvider {
    @State static var posts = [Post(postID: "", userID: "", displayName: "", caption: "", postImageURLs: [String](), userImageURL: "", email: "", likeCount: 9, likedBy: [], createdAt: Int(Date().timeIntervalSince1970))]
    static var previews: some View {
        NavigationView {
            FeedView(posts: posts, scrollIndex: 5, title: "")

        }
    }
}
