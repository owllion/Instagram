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
    private var userCollection = store.collection(K.FireStore.User.collectionName)

    @Published var isLoading = false
    
    //MARK: - User data
    @Published var userID: String = ""
    @Published var displayName: String = ""
    @Published var bio: String = ""
    @Published var imageURL: String = ""
    @Published var userPosts: [Post] = [Post]()
    @Published var totalPostLikes: Int = 0
    @Published var totalPosts: Int = 0

    
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
                .whereField(K.FireStore.Post.userIDField, isEqualTo: self.userID)
                .order(by: K.FireStore.Post.createdAtField,descending: true)
                .limit(to: 50)
                .getDocuments()

            self.userPosts = []
            
            for doc in snapshot.documents {
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
                    let likeBy = data[K.FireStore.Post.likeByField] as?  Array<String>
                        
                {
                    let newPost = Post(id: UUID().uuidString, postID: postId, userID: userID, displayName: displayName, caption: caption, postImageURL: postImageURL, userImageURL: userImageURL, email: email, likeCount: likeCount , likedBy: likeBy, createdAt: createdAt)
                                        
                    self.userPosts.append(newPost)
                }
            }
            
            self.totalPosts = self.userPosts.count
            self.totalPostLikes = self.userPosts.map { $0.likeCount }.reduce(0, +)
            
            self.isLoading = false
            
        }catch {
            self.isLoading = false
            print(error.localizedDescription,"載入使用者貼文的錯誤")
            self.handleError(error)
        }
    }
    
    @MainActor
    func getPostAuthorInfo(with email: String) async throws {
        do {
            let document = try await userCollection.document(email).getDocument()
            
            self.userID = (document.get(K.FireStore.User.userIDField) as? String)! 
            
            self.displayName = document.get(K.FireStore.User.displayNameField) as? String ?? ""
            self.imageURL = (document.get(K.FireStore.User.imageURLField) as? String)!
            self.bio = document.get(K.FireStore.User.bioField) as? String ?? ""
            
        }catch {
            print(error.localizedDescription,"this is error")
            self.handleError(error)
        }
    }
    
}
