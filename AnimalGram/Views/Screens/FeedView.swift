//
//  FeedView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            Text("Place1")
            Text("Place1")
            Text("Place1")
            Text("Place1")
            Text("Place1")
            Text("Place1")

        }.navigationTitle("FEED VIEW").navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedView()

        }
    }
}
