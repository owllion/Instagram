//
//  MainTabView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/26.
//

import SwiftUI

struct MainTabView: View {
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
            
            NavigationView {
                ProfileView(isMyProfile: true)
            }.tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
