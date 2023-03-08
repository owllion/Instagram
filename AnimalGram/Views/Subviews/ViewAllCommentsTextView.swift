//
//  ViewCommentTextView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/8.
//

import SwiftUI

struct ViewAllCommentsTextView: View, Equatable {
    @State var commentsCount: Int
    
    var body: some View {
        Text("View all \(commentsCount) comments")
            .fontWeight(.light)
            .font(.title3)
            .foregroundColor(Color.gray)
    }
    
}

struct ViewAllCommentsTextView_Previews: PreviewProvider {
    static var previews: some View {
        ViewAllCommentsTextView(commentsCount: 80)
    }
}
