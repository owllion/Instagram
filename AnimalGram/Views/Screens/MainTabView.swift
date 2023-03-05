//
//  MainTabView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/26.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    var body: some View {
            TabView {
                NavigationView {
                    FeedView(title: "Feed")
                }.tabItem {
                    Label("Feed", systemImage: "book.fill")
                }
                
                NavigationView {
                    BrowseView()
                } .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }.toolbar(.visible, for: .tabBar)
                NavigationView {
                    UploadView()
                    
                } .tabItem {
                    Label("Upload", systemImage: "square.and.arrow.up.fill")
                }
                
                NavigationView {
                    ProfileView(email: authViewModel.email, isMyProfile: true)
                }.tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                
                NavigationView {
                    BrowseView()
                }.tabItem {
                    Label("Test", systemImage: "square.and.arrow.up.circle.fill")
                }
            }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
