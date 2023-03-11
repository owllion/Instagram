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
                             .frame(width: 50, height: 50, alignment: .center)
                             .cornerRadius(25)
                     })
            
            VStack(alignment: .leading, spacing: 4) {
                
                //MARK: - USER NAME & Date
                HStack {
                    Text(comment.userName)
                        .foregroundColor(Color.primary)
                        .fontWeight(.medium)
                    
                    Text(
                        TimeInterval(comment.createdAt)
                        .toDate()
                        .timeAgoDisplay()
                    ).foregroundColor(Color.gray)
                }
               
                
                //MARK: - CONTENT
                Text(comment.content)
                    .padding([.top,.trailing], 10)
                    .foregroundColor(.primary)
                    
            }.padding(.leading, 7)
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
                    .padding(.top,8)
            }
            
        }.padding(.all,15)
    }
   
}

struct MessageView_Previews: PreviewProvider {
    @EnvironmentObject static var authViewModel: AuthenticationViewModel
    static var comment = Comment(id: UUID().uuidString, userName: "Tom", userImageURL: "https://res.cloudinary.com/azainseong/image/upload/v1662517415/mij3ogxe5cqxitevri9z.png", content: "Cool", commentID: "35", likeCount: 998, likedBy: [], createdAt: Int(Date().timeIntervalSince1970))
    static var previews: some View {
        MessageView(comment: comment, postID: "")
            .environmentObject(authViewModel)
            .previewLayout(.sizeThatFits)
            
    }
}
