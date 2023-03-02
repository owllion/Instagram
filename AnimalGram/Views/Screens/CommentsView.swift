//
//  CommentsView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct CommentsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var submissionText:String = ""
    @State var comments = [CommentModel]()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(comments, id: \.self) {
                        comment in MessageView(comment: comment)
                    }
                }
            }
            
            HStack {
                
                Image("dog3")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                
                TextField("Add a comment here ...", text: $submissionText)
                Button {
                    print("Oh yes it works!")
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                }
            }.padding(.all,15)
        }
        .padding(.all, 10)
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            getComments()
        }
     
    }
    
    func getComments() {
        print("Get comments from db")
        
        comments = [
            .init(commentID: "", userID: "", username: "Mike", content: "Het cool!", dateCreated: Date()),
            .init(commentID: "", userID: "", username: "Mike", content: "I have second thought about you.", dateCreated: Date()),
            .init(commentID: "", userID: "", username: "Nancy", content: "Cool Dog, 3Q~!", dateCreated: Date()),
            .init(commentID: "", userID: "", username: "Tasha Burnum", content: "Every cellphone comes with compass app, alright?!", dateCreated: Date())
        ]
        
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CommentsView()
                .preferredColorScheme(.dark)
        }
    }
}
