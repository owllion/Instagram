//
//  ImageGridView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct ImageGridView: View {
    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.fixed(20)),
                GridItem(.fixed(20)),
                GridItem(.fixed(20))
            ],
            alignment: .center,
            spacing: nil,
            pinnedViews: []) {
                Text("123")
                Text("456")
                Text("4feergerger")
            }
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView().previewLayout(.sizeThatFits)
    }
}
