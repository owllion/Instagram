//
//  ImageGridView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct ImageGridView: View {
    
    @ObservedObject var data: PostArrayObject
    
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
                ForEach(data.posts, id: \.self) {
                    post in
                    NavigationLink {
                        FeedView(data: PostArrayObject(post: post), title: "postw")
                    } label: {
                        PostView(post: post, showHeaderAndFooter: false)
                    }

                   
                }
               
            }
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(data: PostArrayObject()).previewLayout(.sizeThatFits)
    }
}
