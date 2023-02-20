//
//  CommentsView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct CommentsView: View {
    
    @State var submissionText:String = ""
    //tetField changes the text -> this variable will also change.
    
    var body: some View {
        VStack {
            ScrollView {
                Text("PLACEF")
                Text("PLACEF")
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
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.large)
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
