//
//  ProfileViewModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/27.
//

import SwiftUI
import FirebaseFirestore

private let store = Firestore.firestore()

class ProfileViewModel: ObservableObject {
    private var postCollection = store.collection(K.FireStore.Post.collectionName)

    @Published var isLoading = false
    
    //MARK: - User data
    @Published var displayName: String = ""
    @Published var bio: String = ""
    @Published var imageURL: String = ""
    @Published var userPosts: [Post] = [Post]()

    
    //MARK: - Error Properties
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    //MARK: - Handle Error
    func handleError(_ error: Error){
        self.errorMessage = error.localizedDescription
        self.showAlert.toggle()
    }
    
    
    @MainActor
    func getUserPosts(with userID: String) async throws {
        self.isLoading = true
        
        do {
            let snapshot = try await postCollection
                .whereField(K.FireStore.Post.userIDField, isEqualTo: userID)
                            .order(by: K.FireStore.Post.dateCreated,descending: false)
                            .limit(to: 50)
                            .getDocuments()
            print("this is snapshot", snapshot)
            
            self.userPosts = []
            
            for doc in snapshot.documents {
                let data = doc.data()
                print(data, "This is data")
                
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
                    
                    print("This is mewPost", newPost)
                    
                    self.userPosts.append(newPost)
                }
            }
            
            self.isLoading = false
            
        }catch {
            self.isLoading = false
            print(error.localizedDescription,"這是載入使用者貼文的錯誤")
            self.handleError(error)
        }
    }
    
    
    func getSinglePost(with postID: String) {
        
    }
    
}
