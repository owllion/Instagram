//
//  ContentView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @Environment(\.colorScheme) var colorScheme
    //@State var test: Bool = false
//    @AppStorage("state") var state: String = "signedOut"
        @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

//    
//    init() {
//        state = "signedOut"
//    }
    var body: some View {
        if isLoggedIn {
            MainTabView()
            
        }else {
            NavigationView { SignUpView() }

            
        }
    }
//        switch state {
//        case "signedOut":
//            NavigationView { SignUpView() }
//        case "signedIn":
//            MainTabView()
//       
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .environment(\.colorScheme, .dark)
        }
       
    }
}
