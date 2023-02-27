//
//  PostViewModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/27.
//

import Foundation
import FirebaseFirestore

private let store = Firestore.firestore()

class PostViewModel: ObservableObject {
    private var postCollection = store.collection(K.FireStore.Post.collectionName)
    
    @Published var posts = [Post]()
    
    //MARK: - Error Properties
    @Published var showPostVMError: Bool = false
    @Published var errorMessage: String = ""
    
    //MARK: - Handle Error
    func handleError(_ error: Error){
        errorMessage = error.localizedDescription
        showPostVMError.toggle()
        
    }
    
    //MARK: - FIrebase CRUD
    
    @MainActor func createPost(with caption: String, and image: String, by userID: String, named userName: String) {
        
        let postData: [String: Any] = [
            K.FireStore.Post.postIDField: generatePostIDForCreatingPost(),
            K.FireStore.Post.userIDField: userID,
            K.FireStore.Post.displayNameField: userName,
            K.FireStore.Post.captionField: caption,
            K.FireStore.Post.dataCreated: Date().timeIntervalSince1970
        ]
        
        postCollection.addDocument(data: postData) { error in
            if let error = error {
                self.handleError(error)
                return
            } else {
                print("Successfully post!")
            }
        }
        
    }
    
    func getSinglePost(with postID: String) {
        
    }
    
    func getPosts() {
        postCollection.addSnapshotListener { snapshot, error in
            if let error = error {
                self.showPostVMError.toggle()
                self.errorMessage = error.localizedDescription
                return
            }
            
            self.posts = (snapshot?.documents.compactMap {
                try? $0.data(as: Post.self)
            }) ?? []
        }
    }
    
    func updatePost(_ post: Post) {
        do {
            try postCollection.document(post.postID).setData(from: post)
        } catch {
            self.handleError(error)
        }
    }
    
    func deletePost(_ postID: String) {
        postCollection.document(postID).delete { error in
            if let error = error {
                print("Unable to remove the post: \(error.localizedDescription)")
                self.handleError(error)
            }
            
            
        }
    }
    
    //MARK: - Utility method
    func generatePostIDForCreatingPost() -> String {
        return postCollection.document().documentID
    }
    
    
    
}
