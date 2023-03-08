//
//  SplashScreenView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/5.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject private var authViewModel = AuthenticationViewModel()
    @State var isActive: Bool = false
    
    var body: some View {
        if self.isActive {
            ContentView().environmentObject(authViewModel)
        } else {
            VStack {
                VStack {
                    LoadingView(lottieFile: "ig-ani-loading").frame(width: 150,height: 150)
                    
                    Text("Instagram").font(Font.custom("Billabong", size: 50))
                        
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline:  .now() + 2.0) {
                    self.isActive = true
                }
            }
        }
    
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
