//
//  PostView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct PostView: View {
    @State var postImage:UIImage  = UIImage(named: "dog1")!
    
    @State var post: Post
    @State var animateLike: Bool = false
    @State var showConfirmation: Bool  = false
    @State var dialogType: PostConfirmationOption = .general
    
    var showHeaderAndFooter: Bool
    //not showing header &footer version is for ImageGrid
    
    
    enum PostConfirmationOption {
        case general,reporting
    }
    
    
    var body: some View {
        VStack(alignment: .center,
               spacing: 0) {
            
            //MARK: - HEADER
            if showHeaderAndFooter {
                HStack {
                    
                    //WE can use this is because we're in th navigationView
                    NavigationLink {
                        //isMyProfile = false => 因為這邊是貼文串，點進去當然是別人的
                        ProfileView(isMyProfile: false, profileDisplayName: post.username, profileUserID: post.userID)
                    } label: {
                        Image("dog1").resizable()
                            .scaledToFill().frame(width: 30,height: 30,alignment: .center).cornerRadius(15)
                        Text(post.username)
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    Image(systemName: "ellipsis")
                        .font(.headline)
                        .onTapGesture {
                            showConfirmation.toggle()
                        }.confirmationDialog(
                            dialogType == .general ? "What would you like to do?" : "Why are you reporting this post?",
                            isPresented: $showConfirmation,
                            titleVisibility: .visible
                        ) {
                            if dialogType == .general {
                                Button (role: .destructive){
                                    self.dialogType = .reporting
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        self.showConfirmation.toggle()
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
                                    reportPost(reason: "This is inappropriate")
                                } label: {
                                    Text("This is inappropriate")
                                }
                                
                                Button(role: .destructive) {
                                    reportPost(reason: "This is spam")
                                } label: {
                                    Text("This is spam")
                                }
                                
                                Button(role: .destructive) {
                                    reportPost(reason: "It made me uncomfortable")
                                } label: {
                                    Text("It made me uncomfortable")
                                }
                                
                                
                                //Need to write the btn like this or it will keep asking you to add LocationLocalizedStringKey
                                Button("Cancel", role: .cancel) {
                                    self.dialogType = .general
                                }
                               
                            }
                          

                        }
                }.padding(.all, 6)
            }
            
            
            //MARK: - IMAGE
            ZStack {
                Image(uiImage:postImage)
                    .resizable()
                    .scaledToFit()
                
                LikeAnimationView(animate: $animateLike)
            }
            
            //MARK: - FOOTER
            if showHeaderAndFooter {
                HStack(alignment: .center, spacing: 20) {
                    Image(systemName: post.likedByUser ? "heart.fill" : "heart")
                        .font(.title3)
                        .onTapGesture {
                            if post.likedByUser {
                                unlikePost()
                            } else {
                                likePost()
                                
                            }
                        }.foregroundColor(post.likedByUser ? Color.red : Color.primary)
                    
                    //MARK: - COMMENTS ICON
                    NavigationLink(
                        destination: CommentsView()) {
                            Image(systemName: "bubble.middle.bottom").foregroundColor(.primary)
                        }
                    

                    Image(systemName: "paperplane")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .onTapGesture {
                            sharePost()
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
            
            
        }
    }
    
    func likePost() {
        
        let updatedPost = Post(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreate: post.dateCreate, likeCount: post.likeCount + 1, likedByUser: true)
        
        self.post = updatedPost
        
        animateLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            animateLike = false
        }
    }
    
    func unlikePost() {
        
        let updatedPost = Post(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreate: post.dateCreate, likeCount: post.likeCount - 1, likedByUser: false)
        
        self.post = updatedPost
        
    }
    
    func reportPost(reason: String) {
        print("report!!")
    }
    func sharePost() {
        let defaultText = "Just checking in at \(post.username)'s post"
        
        let image = postImage
        let link = URL(string: "https://www.youtube.com/watch?v=x5ZeAfz4G3s&list=RDx5ZeAfz4G3s&start_radio=1")!
        
        let activityViewController = UIActivityViewController(activityItems:[defaultText,image,link], applicationActivities: nil)
        
        //get the background view controller
        //grabbing the first key window that is found in the whole application,
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }

        guard let firstWindow = firstScene.windows.first else {
            return
        }

        let viewController = firstWindow.rootViewController
        
        viewController?.present(activityViewController, animated: true, completion: nil)
    }

    
    
}


struct PostView_Previews: PreviewProvider {
    static var post: Post = Post(postID: "", userID: "", username: "Tomothee", caption: "Test caption", dateCreate: Date(), likeCount: 0, likedByUser: false)
    
    static var previews: some View {
        PostView(post: post, showHeaderAndFooter: true).previewLayout(.sizeThatFits)
    }
}
