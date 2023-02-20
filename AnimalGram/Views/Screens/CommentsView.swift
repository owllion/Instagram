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
                    <#code#>
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                }.tint(.red)

                
               
            }.padding(.all,15)
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
