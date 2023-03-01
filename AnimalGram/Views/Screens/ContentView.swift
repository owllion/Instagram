//
//  ContentView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var loginViewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        switch loginViewModel.state {
        case .signedOut:
            NavigationView { SignUpView() }
        case .signedIn:
            MainTabView()
            
        }
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
}
