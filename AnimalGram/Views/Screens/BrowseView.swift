//
//  BrowseView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct BrowseView: View {
    
    @ObservedObject var feedViewModel = FeedViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            CarouselView()
            ImageGridView(posts: $feedViewModel.posts)
        }.navigationTitle("Browse")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                feedViewModel.getPosts()
            }
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BrowseView()

        }
    }
}
