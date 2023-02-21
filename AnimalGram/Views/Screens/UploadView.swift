//
//  UploadView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct UploadView: View {
    var body: some View {
        ZStack {
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
                    Text("import photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.MyTheme.purple)
                }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                ).background(Color.MyTheme.yellow)
            }
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100,height: 100,alignment: .center)
                .shadow(radius: 12)
        }.edgesIgnoringSafeArea(.top)
        //top is bacause we have tab at the bottom,so no need to ignore the bottom
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
