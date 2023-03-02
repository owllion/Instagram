import SwiftUI

struct ProfileHeaderView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var totalPosts: Int
    var totalPostLikes: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            //MARK: - PROFILE PICTURE
            AsyncImage(url: URL(string: authViewModel.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(15)
                    
                } placeholder: {
                    ProgressView()
                }.frame(width: 120,height: 120, alignment: .center)
            
            //MARK: - USER NAME
            Text(authViewModel.displayName)
            
            //MARK: - BIO
            Text(authViewModel.bio)
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
            
            HStack(alignment: .center, spacing: 20) {
                
                //MARK: - POSTS
                VStack(alignment: .center, spacing: 5) {
                    Text(String(totalPosts))
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
                    Text(String(totalPostLikes))
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
        ProfileHeaderView(totalPosts: 20, totalPostLikes: 55).previewLayout(.sizeThatFits)
    }
}
