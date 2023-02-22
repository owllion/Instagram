//
//  ProfileView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var showSettings: Bool = false
    
    var isMyProfile: Bool
    //true => show the setting bar,otherwise do not show.
    
    @State var profileDisplayName: String
    //Make it State is bacause there are instances where the profile display name might change.例如去編輯名稱之後這裡的名稱也應該要跟著一起變
    
    var profileUserID: String
    //not change,so no need to use state
    
    var posts = PostArrayObject()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ProfileHeaderView( profileDisplayName: $profileDisplayName)
            Divider()
            ImageGridView(data: posts)
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
            }.sheet(isPresented: $showSettings) {
                SettingsView()
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(isMyProfile: true, profileDisplayName: "Anng", profileUserID: "123456")
        }
        
        
    }
}
