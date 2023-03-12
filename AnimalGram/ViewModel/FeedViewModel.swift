//
//  FeedViewModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/27.
//

import Foundation
import FirebaseFirestore


private let store = Firestore.firestore()

class FeedViewModel: ObservableObject {

    private var postCollection = store.collection(K.FireStore.Post.collectionName)
    
    @Published var posts: [Post] = [Post]()
    @Published var isLoading: Bool = false
    
    //MARK: - Error Properties
    @Published var showFeedAlert: Bool = false
    @Published var alertMessage: String = ""
    
    //MARK: - Handle Error
    func handleError(_ error: Error){
        alertMessage = error.localizedDescription
        showFeedAlert.toggle()
        
    }
    
    func getPosts() {
        self.isLoading = true
        
        postCollection
            .order(by: K.FireStore.Post.createdAtField, descending: true)
            .limit(to: 50)
            .addSnapshotListener { snapshot, error in
                
                //need to reset or it will accumulate all the docs
                self.posts = []
                
                if let error = error {
                    print("FeedVM error")
                    self.isLoading = false
                    
                    self.alertMessage = error.localizedDescription
                    self.showFeedAlert.toggle()
                    return
                }
                for doc in snapshot!.documents {
                    let data = doc.data()
                    
                    if
                        let userID = data[K.FireStore.Post.userIDField] as? String,
                        let postId = data[K.FireStore.Post.postIDField] as? String,
                        let displayName = data[K.FireStore.Post.displayNameField] as? String,
                        let createdAt = data[K.FireStore.Post.createdAtField] as? Int,
                        let caption = data[K.FireStore.Post.captionField] as? String,
                        let postImageURL = data[K.FireStore.Post.postImageURLField] as? String,
                        let userImageURL = data[K.FireStore.Post.userImageURLField] as? String,
                        
                            let email = data[K.FireStore.Post.emailField] as? String,
                        let likeCount = data[K.FireStore.Post.likeCountField] as? Int,
                        let likeBy = data[K.FireStore.Post.likeByField] as? Array<String>
                            
                    {
                        let newPost = Post(id: UUID().uuidString, postID: postId, userID: userID, displayName: displayName, caption: caption, postImageURL: postImageURL, userImageURL: userImageURL, email: email, likeCount: likeCount , likedBy: likeBy, createdAt: createdAt)
                        self.posts.append(newPost)
                    }
                    
                }
                
                //            self.posts = (snapshot?.documents.compactMap {
                //                try? $0.data(as: Post.self)
                //            }) ?? []
                self.isLoading = false
            }
    }
}
