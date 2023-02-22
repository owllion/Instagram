//
//  ContentView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var currentUserID: String? = ""
    //logged in -> has value / otherwise nil
    
    var body: some View {
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
       
            
            ZStack {
                //using ZStack is because if you change the view that's connected to a tabItem(which is ProfileView here),the entire tab migh crash. To avoid that, we're gonna have our 'tabItem' always connected to a ZStack, 然後我們在裡面去change for showing the profileView or ant other newView
                
                if currentUserID != nil {
                    NavigationView {
                        ProfileView(isMyProfile: true, profileDisplayName: "My Profile", profileUserID: "")
                    }
                } else {
                    SignUpView()
                }
                
                
            } .tabItem {
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
