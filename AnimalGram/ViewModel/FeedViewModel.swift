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
    
    @Published var posts = [Post]()
    @Published var isLoadingFeed: Bool = false
    
    //MARK: - Error Properties
    @Published var showFeedAlert: Bool = false
    @Published var alertMessage: String = ""
    
    //MARK: - Handle Error
    func handleError(_ error: Error){
        alertMessage = error.localizedDescription
        showFeedAlert.toggle()
        
    }
    
    
    func getPosts() {
        self.isLoadingFeed = true
        postCollection
            .order(by: K.FireStore.Post.dateCreated)
            .limit(to: 50)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    self.alertMessage = error.localizedDescription
                    self.showFeedAlert.toggle()
                    return
                }
                for doc in snapshot!.documents {
                    let data = doc.data()
                    print("THis is data", data)
                    
                    if
                        let userID = data[K.FireStore.Post.userIDField] as? String,
                        let postId = data[K.FireStore.Post.postIDField] as? String,
                        let displayName = data[K.FireStore.Post.displayNameField] as? String,
                        let dateCreated = data[K.FireStore.Post.dateCreated] as? Int,
                        let caption = data[K.FireStore.Post.captionField] as? String,
                        let postImageURL = data[K.FireStore.Post.postImageURLField] as? String,
                        let likeCount = data[K.FireStore.Post.likeCountField] as? Int,
                        let likeByUser = data[K.FireStore.Post.likeByUserField] as? Bool
                            
                    {
                        let newPost = Post(id: UUID().uuidString, postID: postId, userID: userID, displayName: displayName, caption: caption, dateCreated: dateCreated, postImageURL: postImageURL, likeCount: likeCount, likedByUser: likeByUser)
                        print(newPost,"THis is newPost")
                        self.posts.append(newPost)
                    }
                    
                    
                
                    
                }
                
                //            self.posts = (snapshot?.documents.compactMap {
                //                try? $0.data(as: Post.self)
                //            }) ?? []
                print(self.posts,"THis is selfPosts")
                self.isLoadingFeed = false
            }
    }
}
