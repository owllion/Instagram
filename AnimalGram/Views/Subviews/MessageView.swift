//
//  MessageView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct MessageView: View {
    var body: some View {
        HStack {
            Image("dog5")
                .resizable()
                .scaledToFill().scaledToFill().frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("USERNAME")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("My first comment here")
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
    static var previews: some View {
        MessageView().previewLayout(.sizeThatFits)
    }
}
