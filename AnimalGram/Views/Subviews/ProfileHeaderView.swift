import SwiftUI

struct ProfileHeaderView: View {
    
    //@Binding var userName: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            //MARK: - PROFILE PICTURE
            Image("dog2")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120, alignment: .center)
                .cornerRadius(60)
            
            //MARK: - USER NAME
            Text("123NameHere")
            
            //MARK: - BIO
            Text("Area where the user can add a bio to their profile!")
                .font(.body)
                .fontWeight(.regular)
            
                .multilineTextAlignment(.center)
            
            HStack(alignment: .center, spacing: 20) {
                
                //MARK: - POSTS
                VStack(alignment: .center, spacing: 5) {
                    Text("5")
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
                    Text("20")
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
        ProfileHeaderView().previewLayout(.sizeThatFits)
    }
}
