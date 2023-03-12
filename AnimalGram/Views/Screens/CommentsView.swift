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
    @State var animate: Bool = false

    
    
    var body: some View {
        VStack {
            ScrollViewReader { value in
                ScrollView {
                    LazyVStack {
                        ForEach(commentViewModel.comments, id: \.self) {
                            comment in MessageView(comment: comment, postID: postID)
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
                                     .frame(width: 50, height: 50, alignment: .center)
                                     .cornerRadius(25)
                             })
                    
                    TextField("Add a comment here ...", text: $submissionText)
                    Button {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            
                            Task {
                                 await commentViewModel.addComment(postID: postID, content: submissionText, imgUrl: authViewModel.imageURL, userName: authViewModel.displayName)
                                    
                                    self.submissionText = ""
                                    
                                    value.scrollTo(commentViewModel.comments.last?.id, anchor: .top)
                               
                            }
                    } label: {
                        if commentViewModel.isLoading {
                            Circle()
                                .stroke(AngularGradient(gradient: Gradient(colors: [Color.primary, Color.primary.opacity(0)]), center: .center))
                                .frame(width: 80, height: 80)
                                .rotationEffect(Angle(degrees: animate ? 360 : 0))
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
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                
                animate.toggle()
            }
            
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
