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
    
    var body: some View {
        switch loginViewModel.state {
        case .signedOut:
            NavigationView { SignUpView() }
        case .signedIn:
            mainContent
        }
    }
        
    var mainContent: some View {
        TabView {
            //NavigationView is for the top title & link
            NavigationView {
                FeedView(data: PostArrayObject(), title: "Feed")
            }.tabItem {
                
                Label("Feed", systemImage: "book.fill")
            }
            
            NavigationView {
                BrowseView()
            } .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }.toolbar(.visible, for: .tabBar)
                .toolbarBackground(.red, for: .tabBar)
            
            
            NavigationView {
                UploadView()
                
            } .tabItem {
                Label("Upload", systemImage: "square.and.arrow.up.fill")
                    
            }
            
            NavigationView {
                ProfileView(isMyProfile: true, profileDisplayName: "My Profile", profileUserID: "")
            }.tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
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
