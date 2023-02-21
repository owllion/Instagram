//
//  ContentView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct ContentView: View {
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
            NavigationView {
                ProfileView(isMyProfile: true, profileDisplayName: "My Profile", profileUserID: "")
            }
            .tabItem {
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
