//
//  FeedView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var feedViewModel = FeedViewModel()
    
    var title: String
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(feedViewModel.posts, id: \.self) { post in
                    PostView(post: post, showHeaderAndFooter: true)
                }
            }
            
        }.navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                feedViewModel.getPosts()
            }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedView(title: "My Post")

        }
    }
}
