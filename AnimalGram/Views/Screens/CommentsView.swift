//
//  CommentsView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct CommentsView: View {
    
    @State var submissionText:String = ""
    //textField changes the text -> this variable will also change.
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
                }.tint(Color.MyTheme.purple)
            }.padding(.all,15)
        }
        .padding(.all, 10)
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            getComments()
        }
     
    }
    
    //這應該另外寫成commentManager
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
            //加上這個，上面的navigation設定才會有效，因為他們就是必須存在於navigationView裡面
            CommentsView()

        }
    }
}
