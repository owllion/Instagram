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
    
    var title: String
    
    var body: some View {
        ZStack {
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
//                .overlay {
//                    ProgressView("Fetching data...")
//                        .progressViewStyle(
//                        CircularProgressViewStyle(tint: .cyan))
//                }
           
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
