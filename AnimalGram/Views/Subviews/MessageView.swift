//
//  MessageView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI
import URLImage
import FirebaseFirestore

struct MessageView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var commentViewModel = CommentViewModel()
    
    var comment: Comment
    var postID: String
    
    var body: some View {
        HStack {
            
            //MARK: - PROFILE IMAGE
            URLImage(
                url: URL(string: comment.userImageURL)!,
                     failure: { error, retry in
                        VStack {
                            Text(error.localizedDescription)
                        }
                    },
                     content: { image in
                         image
                             .resizable()
                             .scaledToFill()
                             .scaledToFill()
                             .frame(width: 40, height: 40, alignment: .center)
                             .cornerRadius(20)
                     })
            
            VStack(alignment: .leading, spacing: 4) {
                
                //MARK: - USER NAME & Date
                HStack {
                    Text(comment.userName)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(TimeInterval(comment.createdAt).toDate().timeAgoDisplay())
                }
               
                
                //MARK: - CONTENT
                Text(comment.content)
                    .padding(.all, 10)
                    .foregroundColor(.primary)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            Spacer(minLength: 0)
            //for making sure message is pushed all the way to the let side of the screen,coz if our msg was a shorter column, we don't want it to be in the center.
            
            VStack {
                Image(systemName: comment.likedBy.contains(authViewModel.userID!) ? "heart.fill" : "heart")
                    .font(.title3)
                    .onTapGesture {
                        if comment.likedBy.contains(authViewModel.userID!) {
                            commentViewModel.unlikePost(postID: postID, userID : authViewModel.userID!, commentID: comment.commentID)
                            
                        } else {
                            commentViewModel.likePost(postID: postID, userID: authViewModel.userID!, commentID: comment.commentID)

                        }
                    }
                    .foregroundColor(comment.likedBy.contains(authViewModel.userID!) ? Color.red : Color.primary)
                
                Text("\(comment.likeCount)")
            }
            
        }
    }
   
}

struct MessageView_Previews: PreviewProvider {
    static var comment = Comment(id: UUID().uuidString, userName: "Tom", userImageURL: "", content: "Cool", commentID: "", likeCount: 998, likedBy: [], createdAt: Int(Date().timeIntervalSince1970))
    static var previews: some View {
        MessageView(comment: comment, postID: "").previewLayout(.sizeThatFits)
    }
}
