import SwiftUI

struct ProfileHeaderView: View {
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var isMyProfile: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            //MARK: - PROFILE PICTURE
            AsyncImage(url: URL(string: isMyProfile ? authViewModel.imageURL : profileViewModel.imageURL)) { image in
                    image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(60)
                    
                } placeholder: {
                    ProgressView()
                }.frame(width: 120,height: 120, alignment: .center)
            
            //MARK: - USER NAME
            Text(profileViewModel.displayName)
            
            //MARK: - BIO
            Text(profileViewModel.bio)
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
            
            HStack(alignment: .center, spacing: 20) {
                
                //MARK: - POSTS
                VStack(alignment: .center, spacing: 5) {
                    Text(String(profileViewModel.totalPosts))
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    //Divider
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: .center)
                    
                    Text("Posts")
                        .font(.callout)
                        .fontWeight(.medium)
                }
                
                //MARK: - LIKES
                VStack(alignment: .center, spacing: 5) {
                    Text("\(Double(profileViewModel.totalPostLikes).kmFormatted)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    //Divider
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: .center)
                    
                    Text("Likes")
                        .font(.callout)
                        .fontWeight(.medium)
                }
            }
        }.frame(maxWidth: .infinity)
            .padding()
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    
    @State static var name: String = "Mike"
    static var previews: some View {
        ProfileHeaderView(isMyProfile: true).previewLayout(.sizeThatFits)
    }
}
