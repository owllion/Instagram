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
    @StateObject private var authViewModel = AuthenticationViewModel()

    init() {
        FirebaseApp.configure()
     }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
//                .onOpenURL { url in
//               GIDSignIn.sharedInstance.handle(url) //For google sign in

            //}
        }
    }
}

extension AnimalGramApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
}
