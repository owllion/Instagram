//
//  loadingBackdropView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/2.
//

import SwiftUI

struct LoadingView: View {
    var lottieFile: String
    
    var body: some View {
        ZStack {
            LottieView(lottieFile: lottieFile, isLoop: false)
               
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.9))
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(lottieFile: "main-loading")
    }
}
