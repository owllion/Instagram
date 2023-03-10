import SwiftUI
import URLImage

struct PostView: View {
        
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var postViewModel = PostViewModel()
    @StateObject var commentsViewModel = CommentViewModel()
    
    @State var currentScale: CGFloat = 0
    
    var post: Post
    var showHeaderAndFooter: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading,spacing: 0) {
                
                //MARK: - Header
                if showHeaderAndFooter {
                    HStack {
                        AvatarWithNavLink(email: post.email, isMyProfile: authViewModel.email == post.email, imageUrl: post.userImageURL, displayName: post.displayName)
                        
                        Image(systemName: "ellipsis")
                            .font(.headline)
                            .rotationEffect(.degrees(90))
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
                                    if (authViewModel.email == post.email) {
                                        Button (role: .destructive) {
                                            Task {
                                                await postViewModel.deletePost(post.postID)
                                            }
                                            
                                        } label: {
                                            Text("Delete")
                                        }
                                        
                                    }
                                   
                                } else {
                                    Button (role: .destructive){
                                        Task {
                                            do {
                                              //  authViewModel.isLoading = true

                                                try await postViewModel.reportPost(reason: "This is inappropriate", postID: post.postID)
                                               // authViewModel.isLoading = false

                                            }catch {
                                              //  authViewModel.isLoading = false

                                                print(error)
                                            }
                                        }
                                       
                                    } label: {
                                        Text("This is inappropriate")
                                    }
                                    
                                    Button(role: .destructive) {
                                        Task {
                                            do {
                                               // authViewModel.isLoading = true
                                                try await postViewModel.reportPost(reason: "This is spam", postID: post.postID)
                                               // authViewModel.isLoading = false
                                            }catch {
                                               // authViewModel.isLoading = false
                                                print(error)
                                            }
                                        }
                                        
                                    } label: {
                                        Text("This is spam")
                                    }
                                    
                                    Button(role: .destructive) {
                                        Task {
                                            do {
                                                
                                               // authViewModel.isLoading = true

                                                try await postViewModel.reportPost(reason: "It made me uncomfortable", postID: post.postID)
                                                
                                                //authViewModel.isLoading = false

                                            }catch {
                                                //authViewModel.isLoading = false

                                                print(error)
                                            }
                                        }
                                       
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
                
                
                //MARK: - Image
                HStack {
                    ZStack {
                        URLImage(
                                url: URL(string: post.postImageURL)!,
                                 failure: { error, retry in
                                    VStack {
                                        Text(error.localizedDescription)
                                    }
                                },
                                 content: { image in
                                    
                                     image.if(showHeaderAndFooter) {
                                         
                                             $0
                                                 .resizable()
                                                 .aspectRatio(contentMode: .fill)
                                     } else: {
                                         $0
                                             .resizable()
                                             .scaledToFill()
                                             .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3 )
                                             .clipped()
                                     }
                                     
                                     
                                 })
                            .scaleEffect(1 + currentScale)
                            .gesture(
                                MagnificationGesture()
                                    .onChanged { value in
                                        self.currentScale = value
                                    }
                                    .onEnded { value in
                                        withAnimation(.spring()) {
                                            currentScale = 0
                                        }
                                    }
                            
                            )
                            
                        LikeAnimationView(animate: $postViewModel.animateLike)
                    }
                }
                
                
                //MARK: - Footer
                if showHeaderAndFooter {
                    
                    //MARK: - icon
                    HStack(spacing: 20) {
                       
                        Image(systemName: post.likedBy.contains(authViewModel.userID!) ? "heart.fill" : "heart")
                            .font(.title3)
                            .onTapGesture {
                                if post.likedBy.contains(authViewModel.userID!) {
                                    postViewModel.unlikePost(post: post, postID: post.postID, userID: authViewModel.userID!)
                                    
                                } else {
                                     postViewModel.likePost(post: post, postID: post.postID, userID: authViewModel.userID!)

                                }
                            }
                            .foregroundColor( post.likedBy.contains(authViewModel.userID!) ? Color.red : Color.primary)

                        //MARK: - COMMENTS ICON
                        NavigationLink(
                            destination: CommentsView(postID: post.postID)) {
                                Image(systemName: "bubble.right").foregroundColor(.primary)
                            }


                        Image(systemName: "paperplane")
                            .font(.title3)
                            .foregroundColor(.primary)
                            .onTapGesture {
                                postViewModel.sharePost(post)
                            }

                        Spacer()
                        
                        Image(systemName: "bookmark")
                            .foregroundColor(.primary)

                    }
                    .font(.title2)
                    .padding(.all,10)
                    
                    //MARK: - likeCount
                    if post.likeCount > 0 {
                        VStack(alignment: .leading) {
                            NavigationLink(destination: LikePostUserListView(postID: post.postID)) {
                                Text("\(post.likeCount) likes")
                                    .fontWeight(.bold)
                            }
                           
                        }.padding(.leading,10)
                    }
                   
                    
                    //MARK: - caption
                    HStack {
                        NavigationLink {
                            ProfileView(email: post.email, isMyProfile: post.email == authViewModel.email)
                        } label: {
                            Text(post.displayName)
                                .fontWeight(.bold)
                        }

                        Text(post.caption)
                        Spacer(minLength: 0)
                        //when caption == entire screen,then len== 0; otherwise certain amount.
                    }.padding([.leading,.top],10)
                    
                    //MARK: - viewAllComments & Date
                    
                        if commentsViewModel.commentsCount > 0 {
                            HStack {
                                NavigationLink(
                                    destination: CommentsView(postID: post.postID)) {
                                        Text("View all \(commentsViewModel.commentsCount) comments")
                                            .fontWeight(.light)
                                            .font(.title3)
                                            .foregroundColor(Color.gray)
                                    }
                            } .padding([.leading,.top], 10)
                                .frame(height: 30)
                        }
                        
                    
                       
                    
                    HStack {
                        if (TimeInterval(post.createdAt).toDate().isInWeek()) {
                            Text(TimeInterval(post.createdAt).toDate().timeAgoDisplay())
                                .font(.caption)
                                .foregroundColor(Color.gray)
                        } else {
                            Text(TimeInterval(post.createdAt).toDateString())
                                .font(.caption)
                                .foregroundColor(Color.gray)
                        }
                    }.padding([.leading,.top], 10)
                    
                }
            }.onAppear {
                Task {
                   await commentsViewModel.getCommentsCount(postID: post.postID)
                        
                }
   
            }
            .alert(isPresented: $postViewModel.showAlert) {
                () -> Alert in return Alert(title: Text(postViewModel.alertMessage), message: nil, dismissButton: .default(Text("OK")))
            }

        }
        
    }
}


struct PostView_Previews: PreviewProvider {
    @State static var isLoading: Bool = false
    static var post: Post = Post(postID: "", userID: "", displayName: "Tomothee", caption: "Test caption", postImageURL: "", userImageURL: "", email: "", likeCount: 0, likedBy: ["123"], createdAt: Int(Date().timeIntervalSince1970))
    
    static var previews: some View {
        PostView(post: post, showHeaderAndFooter: true).previewLayout(.sizeThatFits)
    }
}

