//
//  MessageView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct MessageView: View {
    
    @State var comment:CommentModel
    
    var body: some View {
        HStack {
            
            //MARK: - PROFILE IMAGE
            Image("dog5")
                .resizable()
                .scaledToFill().scaledToFill().frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 4) {
                
                //MARK: - USER NAME
                Text(comment.username)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                //MARK: - CONTENT
                Text(comment.content)
                    .padding(.all, 10)
                    .foregroundColor(.primary)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            Spacer(minLength: 0)
            //for making sure message is pushed all the way to the let side of the screen,coz if our msg was a shorter column, we don't want it to be in the center.
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var comment = CommentModel(commentID: "", userID: "", username: "Mike Willer", content: "Love your dog!", dateCreated: Date())
    static var previews: some View {
        MessageView(comment: comment).previewLayout(.sizeThatFits)
    }
}
