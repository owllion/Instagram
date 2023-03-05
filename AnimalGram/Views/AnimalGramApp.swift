//
//  AnimalGramApp.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct AnimalGramApp: App {
    init() {
        FirebaseApp.configure()
     }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}

extension AnimalGramApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
}
