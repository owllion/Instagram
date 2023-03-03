//
//  CommentsView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI
import URLImage

struct CommentsView: View {
    
    var postID: String
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    @StateObject var commentViewModel = CommentViewModel()
    @State var submissionText : String = ""
    
    var body: some View {
        VStack {
            ScrollViewReader { value in
                ScrollView {
                    LazyVStack {
                        ForEach(commentViewModel.comments, id: \.self) {
                            comment in MessageView(comment: comment)
                        }
                    }
                }
                HStack {
                    
                    URLImage(
                        url: URL(string: authViewModel.imageURL)!,
                             failure: { error, retry in
                                VStack {
                                    Text(error.localizedDescription)
                                    Image(systemName: "exclamationmark.square.fill")
                                }
                            },
                             content: { image in
                                 image
                                     .resizable()
                                     .scaledToFill()
                                     .frame(width: 40, height: 40, alignment: .center)
                                     .cornerRadius(20)
                             })
                    
                    TextField("Add a comment here ...", text: $submissionText)
                    Button {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            
                            Task {
                                do {
                                    try await commentViewModel.addComment(postID: postID, content: submissionText, imgUrl: authViewModel.imageURL, userName: authViewModel.displayName)
                                    
                                    self.submissionText = ""
                                    
                                    value.scrollTo(commentViewModel.comments.last?.id, anchor: .top)
                                }catch {
                                    
                                }
                            }
                    } label: {
                        if commentViewModel.isLoading {
                            CircularProgressView()
                        } else {
                            Image(systemName: "paperplane.fill")
                                .font(.title2)
                        }
                        
                    } .disabled(self.submissionText == "" ? true : false)
                }.padding(.all,15)
                   
                
            }
            
            
           
        }
        .padding(.all, 10)
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            commentViewModel.getComments(postID: postID)
            
        }.alert(isPresented: $commentViewModel.showAlert) {
            return Alert(
                title: Text("Error!"),
                message: Text(commentViewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
     
    }

}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CommentsView(postID: "")
                .preferredColorScheme(.dark)
        }
    }
}
