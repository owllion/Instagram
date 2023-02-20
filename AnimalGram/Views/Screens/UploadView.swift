//
//  UploadView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct UploadView: View {
    var body: some View {
        VStack {
            
            Button {
                print("ff")
            } label: {
                Text("Take photo".uppercased())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.MyTheme.yellow)
            }.frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            ).background(Color.MyTheme.purple)
            
            Button {
                print("ff")
            } label: {
                Text("Take photo".uppercased())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.MyTheme.purple)
            }.frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            ).background(Color.MyTheme.yellow)

            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
