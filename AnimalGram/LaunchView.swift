//
//  LaunchView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/5.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
            
            VStack {
                LoadingView(lottieFile: "ig-ani-loading").frame(width: 150,height: 150)
                
                Text("Instagram").font(Font.custom("Billabong", size: 50))
                    
            }.onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    print("fj")
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
