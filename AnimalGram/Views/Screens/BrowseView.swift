//
//  BrowseView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct BrowseView: View {
    var posts = PostArrayObject()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            CarouselView()
            ImageGridView(data: posts)
        }.navigationTitle("Browse").navigationBarTitleDisplayMode(.large)
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BrowseView()

        }
    }
}
