//
//  ContentView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct ContentView: View {
    
    var currentUserID: String? = nil
    //logged in -> has value / otherwise nil
    
    var body: some View {
        TabView {
            //NavigationView is for the top title & link
            NavigationView {
                FeedView(data: PostArrayObject(), title: "Feed")
            }.tabItem {
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
            NavigationView {
               BrowseView()
            } .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Browse")
            }
            NavigationView {
                UploadView()
                   
            } .tabItem {
                Image(systemName: "square.and.arrow.up.fill")
                Text("Upload")
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
                Image(systemName: "person.fill")
                Text("Profile")
            }
           
        }.tint(Color.MyTheme.purple)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
