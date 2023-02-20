//
//  FeedView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct FeedView: View {
    
    //subscirbe for the change of the data list.
    @ObservedObject var data:PostArrayObject
    var title:String
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(data.posts, id: \.self) { post in
                    PostView(post: post, showHeaderAndFooter: true)
                }
            }
            
        }.navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedView(data: PostArrayObject(), title: "My Dog")

        }
    }
}
