//
//  LikePostUserListView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/6.
//

import SwiftUI
import URLImage


struct LikePostUserListView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var userListViewModel = LikePostUserListViewModel()
    
    var postID: String
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(userListViewModel.searchResultList, id: \.self) { user in
                    HStack() {
                        AvatarWithNavLink(email: user.email, isMyProfile: authViewModel.email == user.email , imageUrl: user.imageURL, displayName: user.displayName, width: 70, height: 70, cornerRadius: 35)
                    }
                    
                }
            }.padding(.all,15)
        }
        .navigationTitle("Likes")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            Task {
                do {
                    try await userListViewModel.getUsers(postID: postID)
                    
                }catch {}
            }
        }
        .searchable(text: $userListViewModel.searchText,placement:  .navigationBarDrawer(displayMode: .always), prompt: "Search user name") {
            ForEach(userListViewModel.userNames, id: \.self) {
                suggestion in
                    Text(suggestion)
                    .searchCompletion(suggestion)
            }
            
        }
        
    }
}

struct LikePostUserListView_Previews: PreviewProvider {
    static var previews: some View {
        LikePostUserListView(postID: "")
    }
}
