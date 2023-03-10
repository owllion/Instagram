//
//  ProfileView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var showSettings: Bool = false
    
    var email: String
    var isMyProfile: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            ProfileHeaderView(isMyProfile: isMyProfile)
                .environmentObject(profileViewModel)
            
            Divider()
            ImageGridView(posts: profileViewModel.userPosts, from: "profile", userID: profileViewModel.userID)
            
        }.navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "line.horizontal.3")
                    }.tint(colorScheme == .light ? Color.MyTheme.purple : Color.MyTheme.yellow)
                        .opacity(isMyProfile ? 1.0 : 0.0)
                }
            }
            .onAppear {
                Task {
                    
                    await profileViewModel.getPostAuthorInfo(with: email)
                    
                    
                }
                profileViewModel.getUserPosts(with: profileViewModel.userID)
                
              
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
                    .environmentObject(authViewModel)
                    .environmentObject(profileViewModel)
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            ProfileView(email: "", isMyProfile: true)
        }
        
        
    }
}
