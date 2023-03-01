//
//  PostView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct PostView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var postViewModel = PostViewModel()
    @State var post: Post
    
    var showHeaderAndFooter: Bool
    //not showing header &footer version is for ImageGrid

    var body: some View {
        VStack(alignment: .center,
               spacing: 0) {
            
            //MARK: - HEADER
            if showHeaderAndFooter {
                HStack {
                    NavigationLink {
                        //isMyProfile = false => 因為這邊是貼文串，點進去當然是別人的
                        ProfileView(isMyProfile: false)
                    } label: {
                        Image("dog1").resizable()
                            .scaledToFill().frame(width: 30,height: 30,alignment: .center).cornerRadius(15)
                        Text(post.displayName)
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    Image(systemName: "ellipsis")
                        .font(.headline)
                        .onTapGesture {
                            postViewModel.showConfirmation.toggle()
                        }.confirmationDialog(
                            postViewModel.dialogType == .general ? "What would you like to do?" : "Why are you reporting this post?",
                            isPresented: $postViewModel.showConfirmation,
                            titleVisibility: .visible
                        ) {
                            if postViewModel.dialogType == .general {
                                Button (role: .destructive){
                                    self.postViewModel.dialogType = .reporting
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        self.postViewModel.showConfirmation.toggle()
                                    }
                                } label: {
                                    Text("Report")
                                }
                                
                                Button {
                                    print()
                                } label: {
                                    Text("Learn more..")
                                }
                            } else {
                                Button (role: .destructive){
                                    postViewModel.reportPost(reason: "This is inappropriate")
                                } label: {
                                    Text("This is inappropriate")
                                }
                                
                                Button(role: .destructive) {
                                                            postViewModel.reportPost(reason: "This is spam")
                                } label: {
                                    Text("This is spam")
                                }
                                
                                Button(role: .destructive) {
                                                                        postViewModel.reportPost(reason: "It made me uncomfortable")
                                } label: {
                                    Text("It made me uncomfortable")
                                }
                                
                                
                                //Need to write the btn like this or it will keep asking you to add LocationLocalizedStringKey
                                Button("Cancel", role: .cancel) {
                                    self.postViewModel.dialogType = .general
                                }
                               
                            }
                          

                        }
                }.padding(.all, 6)
            }
            
            
            //MARK: - IMAGE
            ZStack {
                AsyncImage(url: URL(string: post.postImageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)

                    } placeholder: {
                        LottieView(lottieFile: "post-loading")
                     
                    }

                LikeAnimationView(animate: $postViewModel.animateLike)
            }
            
            //MARK: - FOOTER
            if showHeaderAndFooter {
                HStack(alignment: .center, spacing: 20) {
                   
                    Image(systemName: post.likedBy.contains(authViewModel.userID!) ? "heart.fill" : "heart")
                        .font(.title3)
                        .onTapGesture {
                            if post.likedBy.contains(authViewModel.userID!) {
                                self.post = postViewModel.unlikePost(post: post, postID: post.postID, userID: authViewModel.userID!)
                            } else {
                                self.post = postViewModel.likePost(post: post, postID: post.postID, userID: authViewModel.userID!)

                            }
                        }.foregroundColor( post.likedBy.contains(authViewModel.userID!) ? Color.red : Color.primary)

                    //MARK: - COMMENTS ICON
                    NavigationLink(
                        destination: CommentsView()) {
                            Image(systemName: "bubble.middle.bottom").foregroundColor(.primary)
                        }


                    Image(systemName: "paperplane")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .onTapGesture {
                            postViewModel.sharePost(post)
                        }

                    Spacer()

                }.padding(.all,10)
                
                
                if let caption = post.caption {
                    HStack {
                        Text(caption)
                        Spacer(minLength: 0)
                        //when caption == entire screen,then len== 0; otherwise certain amount.
                    }.padding(.all,10)
                }
            }
            
            
        }.onAppear {
            print(authViewModel.displayName ?? "不存在name")
            print(authViewModel.userID ?? "不存在id")
        }
    }
}


struct PostView_Previews: PreviewProvider {
    static var post: Post = Post(postID: "", userID: "", displayName: "Tomothee", caption: "Test caption", dateCreated: Int(Date().timeIntervalSince1970), postImageURL: "", likeCount: 0, likedBy: ["123"])
    
    static var previews: some View {
        PostView(post: post, showHeaderAndFooter: true).previewLayout(.sizeThatFits)
    }
}
