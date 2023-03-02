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
            LottieView(lottieFile: lottieFile)
                .frame(width: 300,height: 800)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.beige.opacity(0.6))
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(lottieFile: "loading2")
    }
}
