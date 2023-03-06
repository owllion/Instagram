//
//  AvatarWithNavLink.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/6.
//

import SwiftUI
import URLImage

struct AvatarWithNavLink: View {
    var email: String
    var isMyProfile: Bool
    var imageUrl: String
    var displayName: String
    var width: CGFloat = 30
    var height: CGFloat = 30
    var cornerRadius: CGFloat = 15
    
    var body: some View {
        NavigationLink {
            ProfileView(email: email, isMyProfile: isMyProfile)
        } label: {
            URLImage(
                url: URL(string: imageUrl)!,
                failure: { error, retry in
                    VStack {
                        Text(error.localizedDescription)
                    }
                },
                content: { image in
                    image
                        .resizable()
                        .scaledToFill().frame(width: width,height: height,alignment: .center).cornerRadius(cornerRadius)
                })
            Text(displayName)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
        Spacer()
    }
}

struct AvatarWithNavLink_Previews: PreviewProvider {
    static var previews: some View {
        AvatarWithNavLink(email: "", isMyProfile: true, imageUrl: "", displayName: "")
    }
}
