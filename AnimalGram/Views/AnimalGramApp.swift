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
    @StateObject private var loginViewModel = LoginViewModel()

    init() {
       setupAuthentication()
     }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginViewModel)
                .onOpenURL { url in
               GIDSignIn.sharedInstance.handle(url) //For google sign in

            }
        }
    }
}

extension AnimalGramApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
}
